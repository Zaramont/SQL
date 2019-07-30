use SwimmerDB
go

if OBJECT_ID('dbo.Pool', 'U') is not null
   drop table dbo.[Pool]
go

create table dbo.[Pool]
(
    PoolID          int             not null    identity,
    City            nvarchar(30)    not null,
    [Name]          nvarchar(20),
    PoolSize        nvarchar(20)    not null,
    ModifiedDate    datetime        not null,

    constraint PK_Pool primary key (
        PoolID
    )
)
go