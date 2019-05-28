@echo off
set sqlcmd="C:\Program Files\Microsoft SQL Server\100\Tools\Binn\SQLCMD.EXE"
set d1="C:\SQL\Code\DDL\Tables\"
set d2="C:\SQL\Code\DDL\Constraints"
set d3= "C:\SQL\Code\ETL\"

cd %d1%
for %%G in (*.sql) do sqlcmd /S . -E -i"%%G"

cd %d2%
for %%G in (*.sql) do sqlcmd /S . -E -i"%%G"

cd %d3%
sqlcmd /S . -E -i"SwimmerDB - ETL - Extract - FromCSV.sql"
sqlcmd /S . -E -i"Swimmerdb - ETL - Transform - dbo.competitions_transformed.sql"
sqlcmd /S . -E -i"Swimmerdb - ETL - Load - SwimmingCompetitionInsertsIntoTables.sql"
pause
