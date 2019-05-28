use SwimmerDB
go


if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Disqualification_Swimmer')
   alter table dbo.Disqualification drop constraint FK_Disqualification_Swimmer
go

alter table dbo.Disqualification add constraint FK_Disqualification_Swimmer foreign key (SwimmerID) references dbo.Swimmer (SwimmerID)
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Disqualification_Competition')
   alter table dbo.Disqualification drop constraint FK_Disqualification_Competition
go

alter table dbo.Disqualification add constraint FK_Disqualification_Competition foreign key (CompetitionID) references dbo.Competition (CompetitionID)
go


if object_id('DF_Disqualification_ModifiedDate', 'D') is not null
   alter table dbo.Disqualification drop constraint DF_Disqualification_ModifiedDate
go

alter table dbo.Disqualification add constraint DF_Disqualification_ModifiedDate default GETDATE() for ModifiedDate
go