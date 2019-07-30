use SwimmerDB
go

if OBJECT_ID('dbo.Competition', 'U') is not null
   drop table dbo.Competition
go

create table dbo.Competition
(
    CompetitionID       int             not null    identity,
    GroupID             int             not null,
    DisciplineID        int             not null,
    PoolID              int             not null,
    [Date]              datetime        not null,
    ModifiedDate        datetime        not null,

    constraint PK_Competition primary key (
        CompetitionID
    )
)
go