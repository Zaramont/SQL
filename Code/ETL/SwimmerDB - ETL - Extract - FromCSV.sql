use SwimmerDB
go

bulk insert dbo.stg_Competitions 
from 'c:/SQL/CompetitionProtocol.csv'
   with (
      format = 'csv',
      codepage = 65001,  
      formatfile = 'c:/SQL/stg_Competitions.fmt',
      fieldterminator = ',' 
)
go