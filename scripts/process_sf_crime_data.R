library(tidyverse)
library(sf)
library(readxl)
library(zoo)

# mass process the four annual PDFs that give us compstat data for 2019-2022ytd
# we don't need to repeat this step here, except for once a month with 2022 file
# source("scripts/process_sfpd_compstat_2019version.R")
# source("scripts/process_sfpd_compstat_2020version.R")
# source("scripts/process_sfpd_compstat_2021version.R")
# source("scripts/process_sfpd_compstat_2022version.R")

# Load pre-processed files for rds store files
# annual crime files scraped from PDFs
sf_crime_2019 <- readRDS("scripts/rds/sf_crime_2019.rds")
sf_crime_2020 <- readRDS("scripts/rds/sf_crime_2020.rds")
sf_crime_2021 <- readRDS("scripts/rds/sf_crime_2021.rds")
sf_crime_2022 <- readRDS("scripts/rds/sf_crime_2022.rds")
# San Francisco police districts geo file with populations
districts_geo <- readRDS("scripts/rds/sfpd_districts.rds")
# recent crime files scraped from SFPD's Tableau site
sf_crime_last12mos_add <- readRDS("scripts/rds/sf_crime_last12mos_add.rds")
sf_crime_ytd <- readRDS("scripts/rds/sf_crime_ytd.rds")

# Combined the annual files and order columns for building tracker table
sf_crime <- cbind(sf_crime_2019,sf_crime_2020,sf_crime_2021,sf_crime_2022)
sf_crime <- sf_crime %>% select(4,1,2,6,10,11,15,14,17)
names(sf_crime) <- c("district","category","total18","total19","total20","total21","ytd22_pdf","ytd21_pdf","update_pdf")
sf_crime$category <- sub("\\*", "", sf_crime$category)



# get both crime category names consistent
sf_crime$category <- str_to_title(sf_crime$category)
sf_crime_ytd$category <- str_to_title(sf_crime_ytd$category)
sf_crime_last12mos_add$category <- str_to_title(sf_crime_last12mos_add$category)
# adapt crime categories to match
sf_crime$category <- case_when(sf_crime$category == "Auto Theft" ~ "Motor Vehicle Theft",
                               sf_crime$category == "Human Trafficking-Involuntary Serv." ~ "Human Trafficking - Inv Serv",
                               sf_crime$category == "Human Trafficking-Sex Act" ~ "Human Trafficking - Sex Act",
                               TRUE ~ sf_crime$category)
sf_crime_ytd$category <- case_when(sf_crime_ytd$category == "Assault" ~ "Aggravated Assault",
                                   TRUE ~ sf_crime_ytd$category)
sf_crime_last12mos_add$category <- case_when(sf_crime_last12mos_add$category == "Assault" ~ "Aggravated Assault",
                                             TRUE ~ sf_crime_last12mos_add$category)

sf_crime <- left_join(sf_crime,sf_crime_ytd,by=c("district"="district","category"="category"))
sf_crime <- left_join(sf_crime,sf_crime_last12mos_add,by=c("district"="district","category"="category"))

# process last 12 mos calculations to do comparable annualized rates and clean up unneeded columns
sf_crime$last12mos <- sf_crime$ytd2022+sf_crime$last12mos_add
sf_crime <- sf_crime %>% select(1:6,10,12,15)

# pull out published totals just for reference
sf_crime_totals <- sf_crime %>% filter(category=="Total Part 1 Violent Crimes" | category=="Total Part 1 Property Crimes" | category=="Total Part 1 Crimes")
sf_crime <- sf_crime %>% filter(category!="Total Part 1 Violent Crimes" & category!="Total Part 1 Property Crimes" & category!="Total Part 1 Crimes" & category!="Theft From Vehicle")

# Get latest date in our file and save for
# automating the updated date text in building tracker
asofdate <- max(sf_crime$updated)
saveRDS(asofdate,"scripts/rds/asofdate.rds")

# Divide into citywide_crime and district_crime files
citywide_crime <- sf_crime %>% filter(district=="Citywide")
district_crime <- sf_crime %>% filter(district!="Citywide")

# Merge the precincts file with geography and populations
districts_geo$district <- str_to_title(districts_geo$district)
district_crime <- full_join(districts_geo %>% select(5:7), district_crime, by="district")
# add zeros where there were no crimes tallied that year
district_crime[is.na(district_crime)] <- 0


# add 3-year totals and annualized averages
district_crime$total_prior3years <- district_crime$total19+
  district_crime$total20+
  district_crime$total21
district_crime$avg_prior3years <- round(((district_crime$total19+
                                            district_crime$total20+
                                            district_crime$total21)/3),1)
# now add the increases or change percentages
district_crime$inc_19to21 <- round(district_crime$total21/district_crime$total19*100-100,1)
district_crime$inc_19tolast12 <- round(district_crime$last12mos/district_crime$total19*100-100,1)
district_crime$inc_21tolast12 <- round(district_crime$last12mos/district_crime$total21*100-100,1)
district_crime$inc_prior3yearavgtolast12 <- round((district_crime$last12mos/district_crime$avg_prior3years)*100-100,0)
# add crime rates for each year
district_crime$rate19 <- round((district_crime$total19/district_crime$population)*100000,1)
district_crime$rate20 <- round((district_crime$total20/district_crime$population)*100000,1)
district_crime$rate21 <- round((district_crime$total21/district_crime$population)*100000,1)
district_crime$rate_last12 <- round((district_crime$last12mos/district_crime$population)*100000,1)
district_crime$rate_prior3years <- 
  round((district_crime$avg_prior3years/district_crime$population)*100000,1)

# Now reduce the precinct down to just the columns we likely need for the tracker pages
# district_crime <- district_crime %>% select(1,4,5,6,26:28,36:40,44:55,29,42)
# for map/table making purposes, changing Inf and NaN in calc fields to NA
district_crime <- district_crime %>%
  mutate(across(where(is.numeric), ~na_if(., Inf)))
district_crime <- district_crime %>%
  mutate(across(where(is.numeric), ~na_if(., "NaN")))

# create a quick long-term annual table
district_yearly <- district_crime %>% select(1,3:7,10) %>% st_drop_geometry()
write_csv(district_yearly,"data/output/yearly/district_yearly.csv")

### CITYWIDE
# set value of sf_population
sf_population <- 815201

# add zeros where there were no crimes tallied that year
citywide_crime[is.na(citywide_crime)] <- 0
# add 3-year annualized averages
citywide_crime$total_prior3years <- citywide_crime$total19+
  citywide_crime$total20+
  citywide_crime$total21
citywide_crime$avg_prior3years <- round(((citywide_crime$total19+
                                            citywide_crime$total20+
                                            citywide_crime$total21)/3),1)
# now add the increases or change percentages
citywide_crime$inc_19to21 <- round(citywide_crime$total21/citywide_crime$total19*100-100,1)
citywide_crime$inc_19tolast12 <- round(citywide_crime$last12mos/citywide_crime$total19*100-100,1)
citywide_crime$inc_21tolast12 <- round(citywide_crime$last12mos/citywide_crime$total21*100-100,1)
citywide_crime$inc_prior3yearavgtolast12 <- round((citywide_crime$last12mos/citywide_crime$avg_prior3years)*100-100,0)
# add crime rates for each year
citywide_crime$rate19 <- round((citywide_crime$total19/sf_population)*100000,1)
citywide_crime$rate20 <- round((citywide_crime$total20/sf_population)*100000,1)
citywide_crime$rate21 <- round((citywide_crime$total21/sf_population)*100000,1)
citywide_crime$rate_last12 <- round((citywide_crime$last12mos/sf_population)*100000,1)
# 3 yr rate
citywide_crime$rate_prior3years <- 
  round((citywide_crime$avg_prior3years/sf_population)*100000,1)
# for map/table making purposes, changing Inf and NaN in calc fields to NA
district_crime <- district_crime %>%
  mutate(across(where(is.numeric), ~na_if(., Inf)))
district_crime <- district_crime %>%
  mutate(across(where(is.numeric), ~na_if(., "NaN")))

# create a quick long-term annual table
citywide_yearly <- citywide_crime %>% select(2:6,9)
# add additional years from state archive of reported ucr crimes back to 2000
yearly_archive <- read_csv("data/source/annual/sf_annual_state.csv")
citywide_yearly <- right_join(citywide_yearly,yearly_archive %>% select(1:18,23),by="category") %>% select(1,7:24,2:6)
# save for annual charts  
write_csv(citywide_yearly,"data/output/yearly/citywide_yearly.csv")

# Now make individual crime files for trackers
# filter precinct versions - using beat for code consistency
murders_district <- district_crime %>% filter(category=="Homicide")
sexassaults_district <- district_crime %>% filter(category=="Rape")
robberies_district <- district_crime %>% filter(category=="Robbery")
assaults_district <- district_crime %>% filter(category=="Aggravated Assault")
burglaries_district <- district_crime %>% filter(category=="Burglary")
thefts_district <- district_crime %>% filter(category=="Larceny Theft")
autothefts_district <- district_crime %>% filter(category=="Motor Vehicle Theft")
# filter citywide versions
murders_city <- citywide_crime %>% filter(category=="Homicide")
sexassaults_city <- citywide_crime %>% filter(category=="Rape")
robberies_city <- citywide_crime %>% filter(category=="Robbery")
assaults_city <- citywide_crime %>% filter(category=="Aggravated Assault")
burglaries_city <- citywide_crime %>% filter(category=="Burglary")
thefts_city <- citywide_crime %>% filter(category=="Larceny Theft")
autothefts_city <- citywide_crime %>% filter(category=="Motor Vehicle Theft")

# make the death rate comparables file unique to this state
deaths <- read_excel("data/source/health/deaths.xlsx") 
deaths <- deaths %>% filter(state=="CA")
deaths$Homicide <- murders_city$rate_last12
write_csv(deaths,"data/source/health/death_rates.csv")

#### 
# Archive latest files as csv and rds store for use in trackers
# First save the weekly files as output csvs for others to use
write_csv(district_crime,"data/output/weekly/district_crime.csv")
write_csv(citywide_crime,"data/output/weekly/citywide_crime.csv")
# Archive a year's worth of week-numbered files from the weekly updates
write_csv(district_crime,paste0("data/output/archive/district_crime_week",sf_tableau_update,".csv"))
write_csv(citywide_crime,paste0("data/output/archive/citywide_crime_week",sf_tableau_update,".csv"))
# Now save the files needed for trackers into RDS store in scripts for GH Actions
# precinct versions
saveRDS(district_crime,"scripts/rds/district_crime.rds")
saveRDS(murders_district,"scripts/rds/murders_district.rds")
saveRDS(sexassaults_district,"scripts/rds/sexassaults_district.rds")
saveRDS(robberies_district,"scripts/rds/robberies_district.rds")
saveRDS(assaults_district,"scripts/rds/assaults_district.rds")
saveRDS(burglaries_district,"scripts/rds/burglaries_district.rds")
saveRDS(thefts_district,"scripts/rds/thefts_district.rds")
saveRDS(autothefts_district,"scripts/rds/autothefts_district.rds")
# city versions
saveRDS(citywide_crime,"scripts/rds/citywide_crime.rds")
saveRDS(murders_city,"scripts/rds/murders_city.rds")
saveRDS(sexassaults_city,"scripts/rds/sexassaults_city.rds")
saveRDS(robberies_city,"scripts/rds/robberies_city.rds")
saveRDS(assaults_city,"scripts/rds/assaults_city.rds")
saveRDS(burglaries_city,"scripts/rds/burglaries_city.rds")
saveRDS(thefts_city,"scripts/rds/thefts_city.rds")
saveRDS(autothefts_city,"scripts/rds/autothefts_city.rds")

### Some tables for charts for our pages
sf_crime_totals %>% write_csv("data/output/yearly/totals_by_type.csv")
citywide_yearly %>% filter(category=="Homicide") %>% write_csv("data/output/yearly/murders_city.csv")
citywide_yearly %>% filter(category=="Rape") %>%  write_csv("data/output/yearly/sexassaults_city.csv")
citywide_yearly %>% filter(category=="Motor Vehicle Theft") %>%  write_csv("data/output/yearly/autothefts_city.csv")
citywide_yearly %>% filter(category=="Larceny Theft") %>%  write_csv("data/output/yearly/thefts_city.csv")
citywide_yearly %>% filter(category=="Burglary") %>%  write_csv("data/output/yearly/burglaries_city.csv")
citywide_yearly %>% filter(category=="Robbery") %>%  write_csv("data/output/yearly/robberies_city.csv")
citywide_yearly %>% filter(category=="Aggravated Assault") %>%  write_csv("data/output/yearly/assaults_city.csv")
