use SwimmerDB
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'AK_Group_Name_Gender')
   alter table dbo.[Group] drop constraint AK_Group_Name_Gender
go

alter table dbo.[Group] add constraint AK_Group_Name_Gender unique 
(
    [Name],
    Gender
)
go


if object_id('DF_Group_ModifiedDate', 'D') is not null
   alter table dbo.[Group] drop constraint DF_Group_ModifiedDate
go

alter table dbo.[Group] add constraint DF_Group_ModifiedDate default GETDATE() for ModifiedDate
go