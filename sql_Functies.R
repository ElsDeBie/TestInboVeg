## INBOVEG queries uit sqlSMSS omzetten naar functies


library(knitr)
library(tidyverse)
library(DBI)

con <- dbConnect(odbc::odbc(), dsn = "Cydonia-prd") 

# Headerinfo

header_info <- function(RecordingGivid) {
  dbGetQuery(con,
    "SELECT 
      ivR.[RecordingGivid]
      , ivS.Name
      , ivR.UserReference
      , ivR.LocationCode
      , ivR.Latitude
      , ivR.Longitude
      , ivR.Area
      , ivR.Length
      , ivR.Width
      , ivR.SurveyId
      , coalesce(area, convert( nvarchar(20),ivR.Length * ivR.Width)) as B
      FROM [dbo].[ivRecording] ivR
      INNER JOIN [dbo].[ivSurvey] ivS on ivS.Id = ivR.SurveyId
      where ivR.NeedsWork = 0
      
      
      ;")
}

# AND ivR.[RecordingGivid] = 'IV2012080710541034'
headerRec <- for (RecordingGivid in 'IV2012080710541034') {
  
  header_info(RecordingGivid = 'IV2012080710541034' )
}


