use SwimmerDB
go


if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Result_Swimmer')
   alter table dbo.Result drop constraint FK_Result_Swimmer
go

alter table dbo.Result add constraint FK_Result_Swimmer foreign key (SwimmerID) references dbo.Swimmer (SwimmerID)
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Result_Competition')
   alter table dbo.Result drop constraint FK_Result_Competition
go

alter table dbo.Result add constraint FK_Result_Competition foreign key (CompetitionID) references dbo.Competition (CompetitionID)
go


if object_id('DF_Result_ModifiedDate', 'D') is not null
   alter table dbo.Result drop constraint DF_Result_ModifiedDate
go

alter table dbo.Result add constraint DF_Result_ModifiedDate default GETDATE() for ModifiedDate
go