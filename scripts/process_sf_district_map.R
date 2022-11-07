library(tidyverse)
library(tidycensus)
library(leaflet)
library(leaflet.extras)
library(leaflet.providers)
library(sp)
library(sf)

# GEOGRAPHY
# downloading geojson of sfpd districts from city open data market
download.file("https://data.sfgov.org/api/geospatial/wkhw-cjsf?method=export&format=GeoJSON",
              "data/source/sf/geo/sf_police_districts.geojson")

# Read in geojson and then transform to sf format
districts_geo <- st_read("data/source/sf/geo/sf_police_districts.geojson") %>% st_transform(3857)

# Get demographic data for Census block groups to aggregate/apportion to precinct geography
# Also transforming to match the planar projection of NYPD's beats spatial file
# This also reduces us down to just the numeric population est and geometry
blocks <- get_decennial(geography = "block", 
                       year = 2020,
                       output = 'wide',
                       variables = "P1_001N", 
                       state = "CA",
                       county = c("San Francisco"),
                       geometry = TRUE) %>%
  rename("population"="P1_001N") %>% 
  select(3) %>%
  janitor::clean_names() %>%
  st_transform(3857)

# Calculate the estimated population of beat geographies/interpolate with tidycensus bgs
# Reminder: ext=true SUMS the population during interpolation
districts_withpop <- st_interpolate_aw(blocks, districts_geo, ext = TRUE)
# Drops geometry so it's not duplicated in the merge
districts_withpop <- st_drop_geometry(districts_withpop)
# Binds that new population column to the table
districts_geo <- cbind(districts_geo,districts_withpop)
# Cleans up unneeded calculation file
rm(districts_withpop, blocks)

# Check total population assigned/estimated across all precincts
sum(districts_geo$population) # tally is 8,801,940 # city's reported pop is 8,804,190 in 2020
# OPEN WORK TO DETERMINE HOW TO DO RATES IN PARTS OF CITY WITH
# WILDLY DIFFERENT DAYTIME POPULATIONS

# Round the population figure; rounded to nearest thousand
districts_geo$population <- round(districts_geo$population,-3)

districts_geo <- districts_geo %>% st_transform(4326)
districts_geo <- st_make_valid(districts_geo)

# saving a clean geojson and separate RDS for use in tracker
file.remove("data/source/sf/geo/sfpd_districts.geojson")
st_write(districts_geo,"data/source/sf/geo/sfpd_districts.geojson")
saveRDS(districts_geo,"scripts/sf/rds/sfpd_districts.rds")

# BARE PRECINCT MAP JUST FOR TESTING PURPOSES
# CAN COMMENT OUT ONCE FINALIZED
# Set bins for beats pop map
popbins <- c(0,75000,90000,100000,125000,150000, Inf)
poppal <- colorBin("YlOrRd", districts_geo$population, bins = popbins)
poplabel <- paste(sep = "<br>", districts_geo$district,prettyNum(districts_geo$population, big.mark = ","))

sfpd_districts_map <- leaflet(districts_geo) %>%
  setView(-122.45, 37.75, zoom = 12) %>% 
  addProviderTiles(provider = "Esri.WorldImagery") %>%
  addProviderTiles(provider = "Stamen.TonerLabels") %>%
  addPolygons(color = "white", popup = poplabel, weight = 2, smoothFactor = 0.5,
              opacity = 0.5, fillOpacity = 0.3,
              fillColor = ~poppal(`population`))
sfpd_districts_map
