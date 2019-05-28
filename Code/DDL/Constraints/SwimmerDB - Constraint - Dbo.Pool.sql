use SwimmerDB
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'AK_Pool_Name_City')
   alter table dbo.[Pool] drop constraint AK_Pool_Name_City
go

alter table dbo.[Pool] add constraint AK_Pool_Name_City unique 
(
    [Name],
    City
)
go


if object_id('DF_Pool_ModifiedDate', 'D') is not null
   alter table dbo.[Pool] drop constraint DF_Pool_ModifiedDate
go

alter table dbo.[Pool] add constraint DF_Pool_ModifiedDate default GETDATE() for ModifiedDate
go