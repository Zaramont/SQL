use SwimmerDB
go

if OBJECT_ID('dbo.Result', 'U') is not null
   drop table dbo.Result
go

create table dbo.Result
(
    ResultID       		int			not null    identity,
    CompetitionID       int    		not null,
    SwimmerID 			int 		not null,
	[Time]				time 		not null,
	ModifiedDate 		datetime	not null,

    constraint PK_Result primary key (
        ResultID
    )
)
go