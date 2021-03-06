use SwimmerDB
go

select distinct pool_city City, pool_description PoolSize
into tempdb.#Pool
from dbo.competitions_transformed

insert into dbo.[Pool](City, PoolSize) 
select p.City, p.PoolSize from tempdb.#Pool as p 
left join dbo.[Pool] p2 on p2.City = p.City and p2.PoolSize = p.PoolSize
where p2.City is null and p2.PoolSize is null

select distinct distance, style 
into tempdb.#Discipline
from dbo.competitions_transformed

insert into dbo.Discipline (Distance, Style)
select d.distance, d.style from tempdb.#Discipline as d 
left join dbo.Discipline d2 on d2.Distance = d.distance and d2.Style = d.style
where d2.Distance is null and d2.Style is null

select distinct team [name], city, country 
into tempdb.#SwimmingClub
from dbo.competitions_transformed

insert into dbo.SwimmingClub([Name], City, Country)
select swc.[name], swc.city, swc.country from tempdb.#SwimmingClub as swc 
left join dbo.SwimmingClub swc2 on swc2.[Name] = swc.[name] and swc2.City = swc.city 
where swc2.[Name] is null and swc2.City is null 

select distinct athlete_group as [name],
iif( charindex('М',athlete_group) > 0 or charindex('Ю',athlete_group) > 0, 'М', 'Ж') as gender
into tempdb.#Group
from dbo.competitions_transformed

insert into dbo.[Group] ([Name], Gender)
select g.[name], g.gender from tempdb.#Group as g 
left join dbo.[Group] g2 on g2.[Name] = g.[name] and g2.Gender = g.gender
where  g2.[Name] is null and g2.Gender is null

;with cte_swimmer
as
(
    select distinct first_name, last_name, birth_year, g.gender gender, sc.SwimmingClubID
    from dbo.competitions_transformed tr
    join dbo.[Group] g on tr.athlete_group = g.[Name]
    join dbo.SwimmingClub sc on tr.team = sc.Name and tr.city = sc.City and tr.country = sc.Country
)
insert into dbo.Swimmer(FirstName, LastName, YearOfBirth, Gender, SwimmingClubID)
select sw.first_name, sw.last_name, sw.birth_year, sw.gender, sw.SwimmingClubID 
from cte_swimmer as sw 
left join dbo.Swimmer sw2 on sw2.FirstName = sw.first_name and sw2.LastName = sw.last_name 
                    and sw2.YearOfBirth = sw.birth_year and sw2.Gender = sw.gender 
where sw2.FirstName is null and LastName is null and sw2.YearOfBirth is null and sw2.Gender is null

;with intermediate_cte 
as
(
    select tr.place, sw.SwimmerID, tr.result, tr.disc, tr.points, tr.[date],
        tr.id, p.PoolID, d.DisciplineID, sc.SwimmingClubID, g.GroupID  
    from dbo.competitions_transformed tr
    join dbo.[Pool] p on tr.pool_city = p.City and tr.pool_description = p.PoolSize
    join dbo.Discipline d on tr.distance = d.Distance and tr.style = d.Style
    join dbo.SwimmingClub sc on tr.team = sc.[Name] and tr.city = sc.City and tr.country = sc.Country
    join dbo.[Group] g on tr.athlete_group = g.[Name]
    join dbo.Swimmer sw on sw.FirstName = tr.first_name and sw.LastName = tr.last_name 
                    and sw.YearOfBirth = tr.birth_year  
)
select * into tempdb.#intermediate_results from intermediate_cte

;with cte_competition
as
(
    select GroupID, DisciplineID, PoolID, [date] as [Date] from tempdb.#intermediate_results
    group by GroupID,DisciplineID,PoolID,[Date]
)
insert into dbo.Competition(GroupID, DisciplineID, PoolID, [Date])
select cmp.GroupID, cmp.DisciplineID, cmp.PoolID, cmp.[date] as [Date] 
from cte_competition cmp
left join dbo.Competition cmp2 on cmp2.GroupID = cmp.GroupID and cmp2.DisciplineID = cmp.DisciplineID
        and cmp2.PoolID = cmp.PoolID                    
where cmp2.GroupID is null and cmp2.DisciplineID is null and cmp2.PoolID is null

;with cte_for_result
as
(
    select ic.SwimmerID, ic.result, cmp.CompetitionID
    from tempdb.#intermediate_results ic
    join dbo.Competition cmp on ic.GroupID = cmp.GroupID and ic.DisciplineID = cmp.DisciplineID
        and ic.PoolID = cmp.PoolID and ic.[Date] = cmp.[Date]   
)

insert into dbo.Result(CompetitionID, SwimmerID, [Time])
select cr.CompetitionID, cr.SwimmerID, cr.result 
from cte_for_result cr
left join dbo.Result r on cr.CompetitionID = r.CompetitionID and cr.SwimmerID = r.SwimmerID
where r.CompetitionID is null and r.SwimmerID is null and cr.result is not null


;with cte_for_disc
as
(
    select ic.SwimmerID, ic.disc, cmp.CompetitionID
    from tempdb.#intermediate_results ic
    join dbo.Competition cmp on ic.GroupID = cmp.GroupID and ic.DisciplineID = cmp.DisciplineID
        and ic.PoolID = cmp.PoolID and ic.[Date] = cmp.[Date]   
)
insert into dbo.Disqualification(CompetitionID, SwimmerID)
select cr.CompetitionID, cr.SwimmerID
from cte_for_disc as cr
left join dbo.Disqualification d on d.CompetitionID = cr.CompetitionID and d.SwimmerID = cr.SwimmerID
where d.CompetitionID is null and d.SwimmerID is null and cr.disc is not null

drop table tempdb.#intermediate_results