use SwimmerDB
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'AK_SwimmingClub_Name_City')
   alter table dbo.SwimmingClub drop constraint AK_SwimmingClub_Name_City
go

alter table dbo.SwimmingClub add constraint AK_SwimmingClub_Name_City unique 
(
    [Name],
    City
)
go


if object_id('DF_SwimmingClub_ModifiedDate', 'D') is not null
   alter table dbo.SwimmingClub drop constraint DF_SwimmingClub_ModifiedDate
go

alter table dbo.SwimmingClub add constraint DF_SwimmingClub_ModifiedDate default GETDATE() for ModifiedDate
go