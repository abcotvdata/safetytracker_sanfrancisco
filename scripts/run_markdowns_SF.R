library(rmarkdown)

# Code to build each of the trackers
# Includes loading pre-processed and stored dfs
# Grouped by each page to allow for individual or mass processing

# MURDERS
# Load RDS
murders_beat <- readRDS("scripts/sf/rds/murders_district.rds")
murders_city <- readRDS("scripts/sf/rds/murders_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker.Rmd', 
                  output_dir = "docs",
                  output_file = 'San_Francisco_Safety_Tracker.html')

# BURGLARIES
# Load RDS
burglaries_beat <- readRDS("scripts/sf/rds/burglaries_district.rds")
burglaries_city <- readRDS("scripts/sf/rds/burglaries_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker_Burglaries.Rmd', 
                  output_dir = "docs",
                  output_file = "San_Francisco_Safety_Tracker_Burglaries.html")

# THEFTS
# Load RDS
larcenies_beat <- readRDS("scripts/sf/rds/thefts_district.rds")
larcenies_city <- readRDS("scripts/sf/rds/thefts_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker_Thefts.Rmd', 
                  output_dir = "docs",
                  output_file = 'San_Francisco_Safety_Tracker_Thefts.html')

# AUTO THEFTS
# Load RDS
autothefts_beat <- readRDS("scripts/sf/rds/autothefts_district.rds")
autothefts_city <- readRDS("scripts/sf/rds/autothefts_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker_VehicleThefts.Rmd', 
                  output_dir = "docs",
                  output_file = 'San_Francisco_Safety_Tracker_VehicleThefts.html')

# ROBBERIES
# Load RDS
robberies_beat <- readRDS("scripts/sf/rds/robberies_district.rds")
robberies_city <- readRDS("scripts/sf/rds/robberies_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker_Robberies.Rmd', 
                  output_dir = "docs",
                  output_file = 'San_Francisco_Safety_Tracker_Robberies.html')

# ASSAULTS
# Load RDS
assaults_beat <- readRDS("scripts/sf/rds/assaults_district.rds")
assaults_city <- readRDS("scripts/sf/rds/assaults_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker_Assaults.Rmd', 
                  output_dir = "docs",
                  output_file = 'San_Francisco_Safety_Tracker_Assaults.html')

# SEXUAL ASSAULTS
# Load RDS
sexassaults_beat <- readRDS("scripts/sf/rds/sexassaults_district.rds")
sexassaults_city <- readRDS("scripts/sf/rds/sexassaults_city.rds")
# Render page
rmarkdown::render('scripts/sf/San_Francisco_Safety_Tracker_SexualAssaults.Rmd', 
                  output_dir = "docs",
                  output_file = 'San_Francisco_Safety_Tracker_SexualAssaults.html')

