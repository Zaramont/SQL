use SwimmerDB
go

if OBJECT_ID('dbo.Disqualification', 'U') is not null
   drop table dbo.Disqualification
go

create table dbo.Disqualification
(
    DisqualificationID      int             not null    identity,
    CompetitionID           int             not null,
    SwimmerID               int             not null,
    Reason                  nvarchar(50),
    ModifiedDate            datetime        not null,

    constraint PK_Disqualification primary key (
        DisqualificationID
    )
)
go