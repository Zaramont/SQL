use SwimmerDB
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'AK_Discipline_Style_Distance')
   alter table dbo.Discipline drop constraint AK_Discipline_Style_Distance
go

alter table dbo.Discipline add constraint AK_Discipline_Style_Distance unique 
(
    Style,
    Distance
)
go


if object_id('DF_Discipline_ModifiedDate', 'D') is not null
   alter table dbo.Discipline drop constraint DF_Discipline_ModifiedDate
go

alter table dbo.Discipline add constraint DF_Discipline_ModifiedDate default GETDATE() for ModifiedDate
go