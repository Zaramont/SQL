use SwimmerDB
go


if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Competition_Group')
   alter table dbo.Competition drop constraint FK_Competition_Group
go

alter table dbo.Competition add constraint FK_Competition_Group foreign key (GroupID) references dbo.[Group] (GroupID)
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Competition_Discipline')
   alter table dbo.Competition drop constraint FK_Competition_Discipline
go

alter table dbo.Competition add constraint FK_Competition_Discipline foreign key (DisciplineID) references dbo.Discipline (DisciplineID)
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'FK_Competition_Pool')
   alter table dbo.Competition drop constraint FK_Competition_Pool
go

alter table dbo.Competition add constraint FK_Competition_Pool foreign key (PoolID) references dbo.[Pool] (PoolID)
go

if object_id('DF_Competition_ModifiedDate', 'D') is not null
   alter table dbo.Competition drop constraint DF_Competition_ModifiedDate
go

alter table dbo.Competition add constraint DF_Competition_ModifiedDate default GETDATE() for ModifiedDate
go