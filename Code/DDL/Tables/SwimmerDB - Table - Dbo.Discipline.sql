use SwimmerDB
go

if OBJECT_ID('dbo.Discipline', 'U') is not null
   drop table dbo.Discipline
go

create table dbo.Discipline
(
    DisciplineID        int             not null    identity,
    Style               nvarchar(30)    not null,
    Distance            nvarchar(4)     not null,
    ModifiedDate        datetime        not null,

    constraint PK_Discipline primary key (
        DisciplineID
    )
)
go