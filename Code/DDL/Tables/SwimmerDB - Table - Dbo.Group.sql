use SwimmerDB
go

if OBJECT_ID('dbo.Group', 'U') is not null
   drop table dbo.[Group]
go

create table dbo.[Group]
(
    GroupID             int             not null    identity,
    [Name]              nvarchar(50),
    Gender              nvarchar(1),
    LimitDescription    nvarchar(50),
    ModifiedDate        datetime        not null,

    constraint PK_Group primary key (
        GroupID
    )
)
go