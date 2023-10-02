# mass process the four annual PDFs that give us compstat data for 2019-2022ytd

source("scripts/sf/process_sfpd_compstat_2019version.R")
source("scripts/sf/process_sfpd_compstat_2020version.R")
source("scripts/sf/process_sfpd_compstat_2021version.R")
source("scripts/sf/process_sfpd_compstat_2022version.R")

past_crime_all <- cbind(past_crime_all_2019,past_crime_all_2020,past_crime_all_2021,past_crime_all_2022)
past_crime_all <- past_crime_all %>% select(4,1,2,6,10,11,15,14,17)
names(past_crime_all) <- c("district","category","total2018","total2019","total2020","total2021","total2022","ytd_compare_2021","update_date")
past_crime_all$category <- sub("\\*", "", past_crime_all$category)

# mass download all of the pdfs containing
# sfpd compstat citywide and by district as
# posted on the city's web site for archives
# we are only using, to start, year-end ones
# but grabbing all for redundancy purposes

library(rvest)
library(XML)

# Set url for the main page where the precinct Excel links are based
sfpd_url <- "https://www.sanfranciscopolice.org/stay-safe/crime-data/crime-reports"
# Scrape all links on the page
sf_links <- readLines(sfpd_url) %>% getHTMLLinks
# Extract a list of just the links that include the Excel files
sf_pdfFiles <- grep("\\.pdf", sf_links)
# Replaces the list of values with just the desired Excel links
sf_links <- sf_links[sf_pdfFiles]
rm(sf_pdfFiles)
# Prepend the urls in the list to get full urls for batch download
sf_links2 <- paste0("https://www.sanfranciscopolice.org",sf_links,sep="")
# Run function to download every file from the list of urls

# into new sf source directory called pdf
for (link in sf_links) {
  try(download.file(link, destfile = paste0("data/source/sf/pdf/",basename(link),sep=""))) }
# into new sf source directory called pdf
for (link in sf_links2) {
  try(download.file(link, destfile = paste0("data/source/sf/pdf/",basename(link),sep=""))) }
