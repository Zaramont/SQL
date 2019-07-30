use SwimmerDB
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'AK_Swimmer_FirstName_LastName_YearOfBirth_Gender')
   alter table dbo.Swimmer drop constraint AK_Swimmer_FirstName_LastName_YearOfBirth_Gender
go

alter table dbo.Swimmer add constraint AK_Swimmer_FirstName_LastName_YearOfBirth_Gender unique 
(
    FirstName,
    LastName,
    YearOfBirth,
    Gender
)
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Swimmer_SwimmingClub')
   alter table dbo.Swimmer drop constraint FK_Swimmer_SwimmingClub
go

alter table dbo.Swimmer add constraint FK_Swimmer_SwimmingClub foreign key (SwimmingClubID) references dbo.SwimmingClub (SwimmingClubID)
go


if object_id('DF_Swimmer_ModifiedDate', 'D') is not null
   alter table dbo.Swimmer drop constraint DF_Swimmer_ModifiedDate
go

alter table dbo.Swimmer add constraint DF_Swimmer_ModifiedDate default GETDATE() for ModifiedDate
go