library(tidyverse)
library(tidycensus)
library(readxl)
library(leaflet)
library(leaflet.extras)
library(leaflet.providers)
library(sp)
library(sf)
library(lubridate)

# Save for backup the archived files from Oakland
download.file("https://data.oaklandca.gov/api/views/ppgh-7dqv/rows.csv?accessType=DOWNLOAD&bom=true&format=true",
              "oakland_crimes.csv")
download.file("https://data.oaklandca.gov/api/geospatial/ppgh-7dqv?method=export&format=GeoJSON",
              "oakland_crimes.geojson")

# Save for backup the archived files from san Francisco
# source here https://data.sfgov.org/Public-Safety/Police-Department-Incident-Reports-2018-to-Present/wg3w-h783
download.file("https://data.sfgov.org/api/views/wg3w-h783/rows.csv?accessType=DOWNLOAD",
              "sf_callsforservice.csv")

# Save for backup the archived files from San Jose
# Sourced from this San Jose government open data portal:
# https://data.sanjoseca.gov/dataset/police-calls-for-service
# The 2022 file at least (check previous ones too) has multiple records for many calls
# These are dupes and the only field differing is the "start date" field; need to dedupe
download.file("https://data.sanjoseca.gov/dataset/c5929f1b-7dbe-445e-83ed-35cca0d3ca8b/resource/721b045a-51f2-4e58-b571-4628f7248783/download/policecalls2022.csv",
              "sanjose_policecalls_2022.csv")
download.file("https://data.sanjoseca.gov/dataset/c5929f1b-7dbe-445e-83ed-35cca0d3ca8b/resource/9ca4f4d5-2a86-4a26-9a63-5956e68571f2/download/policecalls2021.csv",
              "sanjose_policecalls_2021.csv")
download.file("https://data.sanjoseca.gov/dataset/c5929f1b-7dbe-445e-83ed-35cca0d3ca8b/resource/aa926acb-63e0-425b-abea-613d293b5b46/download/policecalls2020.csv",
              "sanjose_policecalls_2020.csv")
download.file("https://data.sanjoseca.gov/dataset/c5929f1b-7dbe-445e-83ed-35cca0d3ca8b/resource/22e37864-017c-4be4-b29a-1ffa0d93f26d/download/policecalls2019.csv",
              "sanjose_policecalls_2019.csv")
download.file("https://data.sanjoseca.gov/dataset/c5929f1b-7dbe-445e-83ed-35cca0d3ca8b/resource/355c3448-b90c-4955-9321-e78e2396648b/download/policecalls2018.csv",
              "sanjose_policecalls_2018.csv")
download.file("https://data.sanjoseca.gov/dataset/c5929f1b-7dbe-445e-83ed-35cca0d3ca8b/resource/80093bd5-386a-4345-b7c0-5877ffd6a6c4/download/policecalls2017.csv",
              "sanjose_policecalls_2017.csv")



# San Francisco police district maps are here
# https://data.sfgov.org/api/geospatial/wkhw-cjsf?method=export&format=GeoJSON
download.file("https://data.sfgov.org/api/geospatial/wkhw-cjsf?method=export&format=GeoJSON",
              "sf_police_districts.geojson")
download.file("https://data.sfgov.org/api/geospatial/p5b7-5n3h?method=export&format=GeoJSON",
              "sf_police_analysisneighborhoods.geojson")

# San Jose police district maps are here
# https://geo.sanjoseca.gov/server/rest/services/PLN/PLN_Geocortex_Public_PRD/MapServer/52
# https://csj.maps.arcgis.com/apps/webappviewer/index.html?id=3c5516412b594e79bd25c49f10fc672f
download.file("https://geo.sanjoseca.gov/server/rest/services/PLN/PLN_Geocortex_Public_PRD/MapServer/52/query?where=0%3D0&text=&objectIds=&time=&timeRelation=esriTimeRelationOverlaps&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&havingClause=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&historicMoment=&returnDistinctValues=false&resultOffset=&resultRecordCount=&returnExtentOnly=false&sqlFormat=none&datumTransformation=&parameterValues=&rangeValues=&quantizationParameters=&featureEncoding=esriDefault&f=geojson",
              "san_jose_police_districts.geojson")

# Oakland police district maps are here
# http://gisapps1.mapoakland.com/policedistricts/
download.file("http://gisapps1.mapoakland.com/oakgis/rest/services/Prod/OPDDistrictsBdrysBeats/MapServer/0/query?where=0%3D0&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&queryByDistance=&returnExtentsOnly=false&datumTransformation=&parameterValues=&rangeValues=&f=geojson",
              "oakland_police_districts.geojson")


oakland_beats <- st_read("oakland_police_districts.geojson") %>%
  st_transform(3857)
san_jose_beats <- st_read("san_jose_police_districts.geojson") %>%
  st_transform(3857)
sf_beats <- st_read("sf_police_districts.geojson") %>%
  st_transform(3857)
sf_analysis_neighborhoods <- st_read("sf_police_analysisneighborhoods.geojson") %>%
  st_transform(3857)

# test to look at quick map of three cities' beats

map_bayareabeats <- leaflet(data = san_jose_beats) %>% 
  setView(-95.45, 29.75, zoom = 10) %>% 
  addProviderTiles(provider = "CartoDB.Positron") %>% 
  addProviderTiles(provider = "Esri.WorldImagery") %>%
  addPolygons(color = "green") %>%
map_bayareabeats



leaflet("oakland_crimes.geojson") %>%
  setView(-73.9, 40.7, zoom = 11) %>% 
  addProviderTiles(provider = "Esri.WorldImagery") %>%
  addCircleMarkers()


sf_callsforservice <- read_csv("sf_callsforservice.csv",
col_types = cols(`Incident Datetime` = col_character(),
`Incident Date` = col_date(format = "%Y/%m/%d"),
`Incident Time` = col_character(),
`Incident Year` = col_character(),
`Row ID` = col_character(), `Incident ID` = col_character(),
`Incident Number` = col_character(),
`CAD Number` = col_character(), `Filed Online` = col_character(),
`Incident Code` = col_character(),
CNN = col_character(), `Supervisor District` = col_character(),
Neighborhoods = col_character(),
`ESNCAG - Boundary File` = col_character(),
`Central Market/Tenderloin Boundary Polygon - Updated` = col_character(),
`Civic Center Harm Reduction Project Boundary` = col_character(),
`HSOC Zones as of 2018-06-05` = col_character(),
`Invest In Neighborhoods (IIN) Areas` = col_character(),
`Current Supervisor Districts` = col_character(),
`Current Police Districts` = col_character())) %>%
  janitor::clean_names()

sf_crime_summary <- sf_callsforservice %>% 
  group_by(incident_category,incident_year) %>%
  summarise(count=n())
sf_crime_summary_district <- sf_callsforservice %>% 
  group_by(police_district,incident_category,incident_year) %>%
  summarise(count=n())
sf_crime_total_analysisneighborhoods <- sf_callsforservice %>% 
  group_by(analysis_neighborhood) %>%
  summarise(count=n())
sf_crime_summary_analysisneighborhoods <- sf_callsforservice %>% 
  group_by(analysis_neighborhood,incident_category,incident_year) %>%
  summarise(count=n())

oakland_crimes$year <- substr(oakland_crimes$DateTime,7,10)
oakland_crime_summary <- oakland_crimes %>% 
  group_by(Description,year) %>%
  summarise(count=n())
oakland_crime_summary_district <- oakland_crimes %>% 
  group_by(PoliceBeat,Description,year) %>%
  summarise(count=n())

sanjose_crime_summary <- sanjose_policecalls_2022 %>% 
  group_by(CALL_TYPE) %>%
  summarise(count=n())
sanjose_crime_summary_address <- sanjose_policecalls_2022 %>% 
  group_by(ADDRESS) %>%
  summarise(count=n())

sanjose_crime_addresses <- sanjose_crime_summary_address %>%
  mutate(id=seq.int(nrow(sanjose_crime_addresses))) %>%
  select(3,1) %>% 
  janitor::clean_names()
sanjose_crime_addresses$city <- "San Jose"
sanjose_crime_addresses$state <- "CA"
sanjose_crime_addresses$zip <- ""
sanjose_crime_addresses$address <- str_replace_all(sanjose_crime_addresses$address,"\\]","")
sanjose_crime_addresses$address <- str_replace_all(sanjose_crime_addresses$address,"\\[","")
# sanjose_crime_addresses$address <- str_replace_all(sanjose_crime_addresses$address,".*-","")



write_csv(head(sanjose_crime_addresses,9999),"sanjose_addresses.csv")

library(censusxy)
sanjose_crimexy2 <- cxy_geocode(sanjose_crime_addresses, street = "address", city = "city", state = "state", 
                               output = "simple", class = "sf")

