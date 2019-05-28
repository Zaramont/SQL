use SwimmerDB
go

if object_id('dbo.stg_Competitions','U') is not null
	drop table dbo.stg_Competitions
go

create table dbo.stg_Competitions
(
	id int			 not null identity,

	F1 nvarchar(255) null,
	F2 nvarchar(255) null,
	F3 nvarchar(255) null,
	F4 nvarchar(255) null,
	F5 nvarchar(255) null,
	F6 nvarchar(255) null,
	F7 nvarchar(255) null,
	

	constraint PK_stg_Competitions primary key
	(
		id
	)
) 
go