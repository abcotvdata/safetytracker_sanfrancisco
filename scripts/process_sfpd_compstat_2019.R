library(pdftools)
library(tidyverse)
library(tidyr)


# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/sf/annual/2019yearend.pdf") %>% strsplit(split = "\n")

# difference with 2022 format is there is one page for each district

### CITY WIDE ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)

# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                "skip1","this_month","skip2",
                "skip3","skip4","skip5",
                "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                        "AGGRAVATED ASSAULT",
                                        "HUMAN TRAFFICKING-SEX ACT",
                                        "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                        "BURGLARY",
                                        "LARCENY THEFT*",
                                        "THEFT FROM VEHICLE*",
                                        "AUTO THEFT",
                                        "ARSON",
                                        "TOTAL PART 1 PROPERTY CRIMES",
                                        "TOTAL PART 1 VIOLENT CRIMES",
                                        "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Citywide"
past_crime_citywide <- past_crime_sf

### CENTRAL ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[2]][1] %>% trimws()
rawtext2 <- pdftext[[2]][2] %>% trimws()
rawtext3 <- pdftext[[2]][3] %>% trimws()
rawtext4 <- pdftext[[2]][4] %>% trimws()
rawtext5 <- pdftext[[2]][5] %>% trimws()
rawtext6 <- pdftext[[2]][6] %>% trimws()
rawtext7 <- pdftext[[2]][7] %>% trimws()
rawtext8 <- pdftext[[2]][8] %>% trimws()
rawtext9 <- pdftext[[2]][9] %>% trimws()
rawtext10 <- pdftext[[2]][10] %>% trimws()
rawtext11 <- pdftext[[2]][11] %>% trimws()
rawtext12 <- pdftext[[2]][12] %>% trimws()
rawtext13 <- pdftext[[2]][13] %>% trimws()
rawtext14 <- pdftext[[2]][14] %>% trimws()
rawtext15 <- pdftext[[2]][15] %>% trimws()
rawtext16 <- pdftext[[2]][16] %>% trimws()
rawtext17 <- pdftext[[2]][17] %>% trimws()
rawtext18 <- pdftext[[2]][18] %>% trimws()
rawtext19 <- pdftext[[2]][19] %>% trimws()
rawtext20 <- pdftext[[2]][20] %>% trimws()
rawtext21 <- pdftext[[2]][21] %>% trimws()
rawtext22 <- pdftext[[2]][22] %>% trimws()
rawtext23 <- pdftext[[2]][23] %>% trimws()
rawtext24 <- pdftext[[2]][24] %>% trimws()
rawtext25 <- pdftext[[2]][25] %>% trimws()
rawtext26 <- pdftext[[2]][26] %>% trimws()
rawtext27 <- pdftext[[2]][27] %>% trimws()
rawtext28 <- pdftext[[2]][28] %>% trimws()
rawtext29 <- pdftext[[2]][29] %>% trimws()
rawtext30 <- pdftext[[2]][30] %>% trimws()
rawtext31 <- pdftext[[2]][31] %>% trimws()
rawtext32 <- pdftext[[2]][32] %>% trimws()
rawtext33 <- pdftext[[2]][33] %>% trimws()
rawtext34 <- pdftext[[2]][34] %>% trimws()
rawtext35 <- pdftext[[2]][35] %>% trimws()
rawtext36 <- pdftext[[2]][36] %>% trimws()
rawtext37 <- pdftext[[2]][37] %>% trimws()
rawtext38 <- pdftext[[2]][38] %>% trimws()
rawtext39 <- pdftext[[2]][39] %>% trimws()
rawtext40 <- pdftext[[2]][40] %>% trimws()
rawtext41 <- pdftext[[2]][41] %>% trimws()
rawtext42 <- pdftext[[2]][42] %>% trimws()
rawtext43 <- pdftext[[2]][43] %>% trimws()
rawtext44 <- pdftext[[2]][44] %>% trimws()
rawtext45 <- pdftext[[2]][45] %>% trimws()
rawtext46 <- pdftext[[2]][46] %>% trimws()
rawtext47 <- pdftext[[2]][47] %>% trimws()
rawtext48 <- pdftext[[2]][48] %>% trimws()
rawtext49 <- pdftext[[2]][49] %>% trimws()
rawtext50 <- pdftext[[2]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Central"
past_crime_central <- past_crime_sf

### SOUTHERN ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[3]][1] %>% trimws()
rawtext2 <- pdftext[[3]][2] %>% trimws()
rawtext3 <- pdftext[[3]][3] %>% trimws()
rawtext4 <- pdftext[[3]][4] %>% trimws()
rawtext5 <- pdftext[[3]][5] %>% trimws()
rawtext6 <- pdftext[[3]][6] %>% trimws()
rawtext7 <- pdftext[[3]][7] %>% trimws()
rawtext8 <- pdftext[[3]][8] %>% trimws()
rawtext9 <- pdftext[[3]][9] %>% trimws()
rawtext10 <- pdftext[[3]][10] %>% trimws()
rawtext11 <- pdftext[[3]][11] %>% trimws()
rawtext12 <- pdftext[[3]][12] %>% trimws()
rawtext13 <- pdftext[[3]][13] %>% trimws()
rawtext14 <- pdftext[[3]][14] %>% trimws()
rawtext15 <- pdftext[[3]][15] %>% trimws()
rawtext16 <- pdftext[[3]][16] %>% trimws()
rawtext17 <- pdftext[[3]][17] %>% trimws()
rawtext18 <- pdftext[[3]][18] %>% trimws()
rawtext19 <- pdftext[[3]][19] %>% trimws()
rawtext20 <- pdftext[[3]][20] %>% trimws()
rawtext21 <- pdftext[[3]][21] %>% trimws()
rawtext22 <- pdftext[[3]][22] %>% trimws()
rawtext23 <- pdftext[[3]][23] %>% trimws()
rawtext24 <- pdftext[[3]][24] %>% trimws()
rawtext25 <- pdftext[[3]][25] %>% trimws()
rawtext26 <- pdftext[[3]][26] %>% trimws()
rawtext27 <- pdftext[[3]][27] %>% trimws()
rawtext28 <- pdftext[[3]][28] %>% trimws()
rawtext29 <- pdftext[[3]][29] %>% trimws()
rawtext30 <- pdftext[[3]][30] %>% trimws()
rawtext31 <- pdftext[[3]][31] %>% trimws()
rawtext32 <- pdftext[[3]][32] %>% trimws()
rawtext33 <- pdftext[[3]][33] %>% trimws()
rawtext34 <- pdftext[[3]][34] %>% trimws()
rawtext35 <- pdftext[[3]][35] %>% trimws()
rawtext36 <- pdftext[[3]][36] %>% trimws()
rawtext37 <- pdftext[[3]][37] %>% trimws()
rawtext38 <- pdftext[[3]][38] %>% trimws()
rawtext39 <- pdftext[[3]][39] %>% trimws()
rawtext40 <- pdftext[[3]][40] %>% trimws()
rawtext41 <- pdftext[[3]][41] %>% trimws()
rawtext42 <- pdftext[[3]][42] %>% trimws()
rawtext43 <- pdftext[[3]][43] %>% trimws()
rawtext44 <- pdftext[[3]][44] %>% trimws()
rawtext45 <- pdftext[[3]][45] %>% trimws()
rawtext46 <- pdftext[[3]][46] %>% trimws()
rawtext47 <- pdftext[[3]][47] %>% trimws()
rawtext48 <- pdftext[[3]][48] %>% trimws()
rawtext49 <- pdftext[[3]][49] %>% trimws()
rawtext50 <- pdftext[[3]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Southern"
past_crime_southern <- past_crime_sf

### BAYVIEW ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[4]][1] %>% trimws()
rawtext2 <- pdftext[[4]][2] %>% trimws()
rawtext3 <- pdftext[[4]][3] %>% trimws()
rawtext4 <- pdftext[[4]][4] %>% trimws()
rawtext5 <- pdftext[[4]][5] %>% trimws()
rawtext6 <- pdftext[[4]][6] %>% trimws()
rawtext7 <- pdftext[[4]][7] %>% trimws()
rawtext8 <- pdftext[[4]][8] %>% trimws()
rawtext9 <- pdftext[[4]][9] %>% trimws()
rawtext10 <- pdftext[[4]][10] %>% trimws()
rawtext11 <- pdftext[[4]][11] %>% trimws()
rawtext12 <- pdftext[[4]][12] %>% trimws()
rawtext13 <- pdftext[[4]][13] %>% trimws()
rawtext14 <- pdftext[[4]][14] %>% trimws()
rawtext15 <- pdftext[[4]][15] %>% trimws()
rawtext16 <- pdftext[[4]][16] %>% trimws()
rawtext17 <- pdftext[[4]][17] %>% trimws()
rawtext18 <- pdftext[[4]][18] %>% trimws()
rawtext19 <- pdftext[[4]][19] %>% trimws()
rawtext20 <- pdftext[[4]][20] %>% trimws()
rawtext21 <- pdftext[[4]][21] %>% trimws()
rawtext22 <- pdftext[[4]][22] %>% trimws()
rawtext23 <- pdftext[[4]][23] %>% trimws()
rawtext24 <- pdftext[[4]][24] %>% trimws()
rawtext25 <- pdftext[[4]][25] %>% trimws()
rawtext26 <- pdftext[[4]][26] %>% trimws()
rawtext27 <- pdftext[[4]][27] %>% trimws()
rawtext28 <- pdftext[[4]][28] %>% trimws()
rawtext29 <- pdftext[[4]][29] %>% trimws()
rawtext30 <- pdftext[[4]][30] %>% trimws()
rawtext31 <- pdftext[[4]][31] %>% trimws()
rawtext32 <- pdftext[[4]][32] %>% trimws()
rawtext33 <- pdftext[[4]][33] %>% trimws()
rawtext34 <- pdftext[[4]][34] %>% trimws()
rawtext35 <- pdftext[[4]][35] %>% trimws()
rawtext36 <- pdftext[[4]][36] %>% trimws()
rawtext37 <- pdftext[[4]][37] %>% trimws()
rawtext38 <- pdftext[[4]][38] %>% trimws()
rawtext39 <- pdftext[[4]][39] %>% trimws()
rawtext40 <- pdftext[[4]][40] %>% trimws()
rawtext41 <- pdftext[[4]][41] %>% trimws()
rawtext42 <- pdftext[[4]][42] %>% trimws()
rawtext43 <- pdftext[[4]][43] %>% trimws()
rawtext44 <- pdftext[[4]][44] %>% trimws()
rawtext45 <- pdftext[[4]][45] %>% trimws()
rawtext46 <- pdftext[[4]][46] %>% trimws()
rawtext47 <- pdftext[[4]][47] %>% trimws()
rawtext48 <- pdftext[[4]][48] %>% trimws()
rawtext49 <- pdftext[[4]][49] %>% trimws()
rawtext50 <- pdftext[[4]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Bayview"
past_crime_bayview <- past_crime_sf

### MISSION ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[5]][1] %>% trimws()
rawtext2 <- pdftext[[5]][2] %>% trimws()
rawtext3 <- pdftext[[5]][3] %>% trimws()
rawtext4 <- pdftext[[5]][4] %>% trimws()
rawtext5 <- pdftext[[5]][5] %>% trimws()
rawtext6 <- pdftext[[5]][6] %>% trimws()
rawtext7 <- pdftext[[5]][7] %>% trimws()
rawtext8 <- pdftext[[5]][8] %>% trimws()
rawtext9 <- pdftext[[5]][9] %>% trimws()
rawtext10 <- pdftext[[5]][10] %>% trimws()
rawtext11 <- pdftext[[5]][11] %>% trimws()
rawtext12 <- pdftext[[5]][12] %>% trimws()
rawtext13 <- pdftext[[5]][13] %>% trimws()
rawtext14 <- pdftext[[5]][14] %>% trimws()
rawtext15 <- pdftext[[5]][15] %>% trimws()
rawtext16 <- pdftext[[5]][16] %>% trimws()
rawtext17 <- pdftext[[5]][17] %>% trimws()
rawtext18 <- pdftext[[5]][18] %>% trimws()
rawtext19 <- pdftext[[5]][19] %>% trimws()
rawtext20 <- pdftext[[5]][20] %>% trimws()
rawtext21 <- pdftext[[5]][21] %>% trimws()
rawtext22 <- pdftext[[5]][22] %>% trimws()
rawtext23 <- pdftext[[5]][23] %>% trimws()
rawtext24 <- pdftext[[5]][24] %>% trimws()
rawtext25 <- pdftext[[5]][25] %>% trimws()
rawtext26 <- pdftext[[5]][26] %>% trimws()
rawtext27 <- pdftext[[5]][27] %>% trimws()
rawtext28 <- pdftext[[5]][28] %>% trimws()
rawtext29 <- pdftext[[5]][29] %>% trimws()
rawtext30 <- pdftext[[5]][30] %>% trimws()
rawtext31 <- pdftext[[5]][31] %>% trimws()
rawtext32 <- pdftext[[5]][32] %>% trimws()
rawtext33 <- pdftext[[5]][33] %>% trimws()
rawtext34 <- pdftext[[5]][34] %>% trimws()
rawtext35 <- pdftext[[5]][35] %>% trimws()
rawtext36 <- pdftext[[5]][36] %>% trimws()
rawtext37 <- pdftext[[5]][37] %>% trimws()
rawtext38 <- pdftext[[5]][38] %>% trimws()
rawtext39 <- pdftext[[5]][39] %>% trimws()
rawtext40 <- pdftext[[5]][40] %>% trimws()
rawtext41 <- pdftext[[5]][41] %>% trimws()
rawtext42 <- pdftext[[5]][42] %>% trimws()
rawtext43 <- pdftext[[5]][43] %>% trimws()
rawtext44 <- pdftext[[5]][44] %>% trimws()
rawtext45 <- pdftext[[5]][45] %>% trimws()
rawtext46 <- pdftext[[5]][46] %>% trimws()
rawtext47 <- pdftext[[5]][47] %>% trimws()
rawtext48 <- pdftext[[5]][48] %>% trimws()
rawtext49 <- pdftext[[5]][49] %>% trimws()
rawtext50 <- pdftext[[5]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Mission"
past_crime_mission <- past_crime_sf

### NORTHERN ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[6]][1] %>% trimws()
rawtext2 <- pdftext[[6]][2] %>% trimws()
rawtext3 <- pdftext[[6]][3] %>% trimws()
rawtext4 <- pdftext[[6]][4] %>% trimws()
rawtext5 <- pdftext[[6]][5] %>% trimws()
rawtext6 <- pdftext[[6]][6] %>% trimws()
rawtext7 <- pdftext[[6]][7] %>% trimws()
rawtext8 <- pdftext[[6]][8] %>% trimws()
rawtext9 <- pdftext[[6]][9] %>% trimws()
rawtext10 <- pdftext[[6]][10] %>% trimws()
rawtext11 <- pdftext[[6]][11] %>% trimws()
rawtext12 <- pdftext[[6]][12] %>% trimws()
rawtext13 <- pdftext[[6]][13] %>% trimws()
rawtext14 <- pdftext[[6]][14] %>% trimws()
rawtext15 <- pdftext[[6]][15] %>% trimws()
rawtext16 <- pdftext[[6]][16] %>% trimws()
rawtext17 <- pdftext[[6]][17] %>% trimws()
rawtext18 <- pdftext[[6]][18] %>% trimws()
rawtext19 <- pdftext[[6]][19] %>% trimws()
rawtext20 <- pdftext[[6]][20] %>% trimws()
rawtext21 <- pdftext[[6]][21] %>% trimws()
rawtext22 <- pdftext[[6]][22] %>% trimws()
rawtext23 <- pdftext[[6]][23] %>% trimws()
rawtext24 <- pdftext[[6]][24] %>% trimws()
rawtext25 <- pdftext[[6]][25] %>% trimws()
rawtext26 <- pdftext[[6]][26] %>% trimws()
rawtext27 <- pdftext[[6]][27] %>% trimws()
rawtext28 <- pdftext[[6]][28] %>% trimws()
rawtext29 <- pdftext[[6]][29] %>% trimws()
rawtext30 <- pdftext[[6]][30] %>% trimws()
rawtext31 <- pdftext[[6]][31] %>% trimws()
rawtext32 <- pdftext[[6]][32] %>% trimws()
rawtext33 <- pdftext[[6]][33] %>% trimws()
rawtext34 <- pdftext[[6]][34] %>% trimws()
rawtext35 <- pdftext[[6]][35] %>% trimws()
rawtext36 <- pdftext[[6]][36] %>% trimws()
rawtext37 <- pdftext[[6]][37] %>% trimws()
rawtext38 <- pdftext[[6]][38] %>% trimws()
rawtext39 <- pdftext[[6]][39] %>% trimws()
rawtext40 <- pdftext[[6]][40] %>% trimws()
rawtext41 <- pdftext[[6]][41] %>% trimws()
rawtext42 <- pdftext[[6]][42] %>% trimws()
rawtext43 <- pdftext[[6]][43] %>% trimws()
rawtext44 <- pdftext[[6]][44] %>% trimws()
rawtext45 <- pdftext[[6]][45] %>% trimws()
rawtext46 <- pdftext[[6]][46] %>% trimws()
rawtext47 <- pdftext[[6]][47] %>% trimws()
rawtext48 <- pdftext[[6]][48] %>% trimws()
rawtext49 <- pdftext[[6]][49] %>% trimws()
rawtext50 <- pdftext[[6]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Northern"
past_crime_northern <- past_crime_sf


### PARK ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[7]][1] %>% trimws()
rawtext2 <- pdftext[[7]][2] %>% trimws()
rawtext3 <- pdftext[[7]][3] %>% trimws()
rawtext4 <- pdftext[[7]][4] %>% trimws()
rawtext5 <- pdftext[[7]][5] %>% trimws()
rawtext6 <- pdftext[[7]][6] %>% trimws()
rawtext7 <- pdftext[[7]][7] %>% trimws()
rawtext8 <- pdftext[[7]][8] %>% trimws()
rawtext9 <- pdftext[[7]][9] %>% trimws()
rawtext10 <- pdftext[[7]][10] %>% trimws()
rawtext11 <- pdftext[[7]][11] %>% trimws()
rawtext12 <- pdftext[[7]][12] %>% trimws()
rawtext13 <- pdftext[[7]][13] %>% trimws()
rawtext14 <- pdftext[[7]][14] %>% trimws()
rawtext15 <- pdftext[[7]][15] %>% trimws()
rawtext16 <- pdftext[[7]][16] %>% trimws()
rawtext17 <- pdftext[[7]][17] %>% trimws()
rawtext18 <- pdftext[[7]][18] %>% trimws()
rawtext19 <- pdftext[[7]][19] %>% trimws()
rawtext20 <- pdftext[[7]][20] %>% trimws()
rawtext21 <- pdftext[[7]][21] %>% trimws()
rawtext22 <- pdftext[[7]][22] %>% trimws()
rawtext23 <- pdftext[[7]][23] %>% trimws()
rawtext24 <- pdftext[[7]][24] %>% trimws()
rawtext25 <- pdftext[[7]][25] %>% trimws()
rawtext26 <- pdftext[[7]][26] %>% trimws()
rawtext27 <- pdftext[[7]][27] %>% trimws()
rawtext28 <- pdftext[[7]][28] %>% trimws()
rawtext29 <- pdftext[[7]][29] %>% trimws()
rawtext30 <- pdftext[[7]][30] %>% trimws()
rawtext31 <- pdftext[[7]][31] %>% trimws()
rawtext32 <- pdftext[[7]][32] %>% trimws()
rawtext33 <- pdftext[[7]][33] %>% trimws()
rawtext34 <- pdftext[[7]][34] %>% trimws()
rawtext35 <- pdftext[[7]][35] %>% trimws()
rawtext36 <- pdftext[[7]][36] %>% trimws()
rawtext37 <- pdftext[[7]][37] %>% trimws()
rawtext38 <- pdftext[[7]][38] %>% trimws()
rawtext39 <- pdftext[[7]][39] %>% trimws()
rawtext40 <- pdftext[[7]][40] %>% trimws()
rawtext41 <- pdftext[[7]][41] %>% trimws()
rawtext42 <- pdftext[[7]][42] %>% trimws()
rawtext43 <- pdftext[[7]][43] %>% trimws()
rawtext44 <- pdftext[[7]][44] %>% trimws()
rawtext45 <- pdftext[[7]][45] %>% trimws()
rawtext46 <- pdftext[[7]][46] %>% trimws()
rawtext47 <- pdftext[[7]][47] %>% trimws()
rawtext48 <- pdftext[[7]][48] %>% trimws()
rawtext49 <- pdftext[[7]][49] %>% trimws()
rawtext50 <- pdftext[[7]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Park"
past_crime_park <- past_crime_sf


### RICHMOND ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[8]][1] %>% trimws()
rawtext2 <- pdftext[[8]][2] %>% trimws()
rawtext3 <- pdftext[[8]][3] %>% trimws()
rawtext4 <- pdftext[[8]][4] %>% trimws()
rawtext5 <- pdftext[[8]][5] %>% trimws()
rawtext6 <- pdftext[[8]][6] %>% trimws()
rawtext7 <- pdftext[[8]][7] %>% trimws()
rawtext8 <- pdftext[[8]][8] %>% trimws()
rawtext9 <- pdftext[[8]][9] %>% trimws()
rawtext10 <- pdftext[[8]][10] %>% trimws()
rawtext11 <- pdftext[[8]][11] %>% trimws()
rawtext12 <- pdftext[[8]][12] %>% trimws()
rawtext13 <- pdftext[[8]][13] %>% trimws()
rawtext14 <- pdftext[[8]][14] %>% trimws()
rawtext15 <- pdftext[[8]][15] %>% trimws()
rawtext16 <- pdftext[[8]][16] %>% trimws()
rawtext17 <- pdftext[[8]][17] %>% trimws()
rawtext18 <- pdftext[[8]][18] %>% trimws()
rawtext19 <- pdftext[[8]][19] %>% trimws()
rawtext20 <- pdftext[[8]][20] %>% trimws()
rawtext21 <- pdftext[[8]][21] %>% trimws()
rawtext22 <- pdftext[[8]][22] %>% trimws()
rawtext23 <- pdftext[[8]][23] %>% trimws()
rawtext24 <- pdftext[[8]][24] %>% trimws()
rawtext25 <- pdftext[[8]][25] %>% trimws()
rawtext26 <- pdftext[[8]][26] %>% trimws()
rawtext27 <- pdftext[[8]][27] %>% trimws()
rawtext28 <- pdftext[[8]][28] %>% trimws()
rawtext29 <- pdftext[[8]][29] %>% trimws()
rawtext30 <- pdftext[[8]][30] %>% trimws()
rawtext31 <- pdftext[[8]][31] %>% trimws()
rawtext32 <- pdftext[[8]][32] %>% trimws()
rawtext33 <- pdftext[[8]][33] %>% trimws()
rawtext34 <- pdftext[[8]][34] %>% trimws()
rawtext35 <- pdftext[[8]][35] %>% trimws()
rawtext36 <- pdftext[[8]][36] %>% trimws()
rawtext37 <- pdftext[[8]][37] %>% trimws()
rawtext38 <- pdftext[[8]][38] %>% trimws()
rawtext39 <- pdftext[[8]][39] %>% trimws()
rawtext40 <- pdftext[[8]][40] %>% trimws()
rawtext41 <- pdftext[[8]][41] %>% trimws()
rawtext42 <- pdftext[[8]][42] %>% trimws()
rawtext43 <- pdftext[[8]][43] %>% trimws()
rawtext44 <- pdftext[[8]][44] %>% trimws()
rawtext45 <- pdftext[[8]][45] %>% trimws()
rawtext46 <- pdftext[[8]][46] %>% trimws()
rawtext47 <- pdftext[[8]][47] %>% trimws()
rawtext48 <- pdftext[[8]][48] %>% trimws()
rawtext49 <- pdftext[[8]][49] %>% trimws()
rawtext50 <- pdftext[[8]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Richmond"
past_crime_richmond <- past_crime_sf


### INGLESIDE ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[9]][1] %>% trimws()
rawtext2 <- pdftext[[9]][2] %>% trimws()
rawtext3 <- pdftext[[9]][3] %>% trimws()
rawtext4 <- pdftext[[9]][4] %>% trimws()
rawtext5 <- pdftext[[9]][5] %>% trimws()
rawtext6 <- pdftext[[9]][6] %>% trimws()
rawtext7 <- pdftext[[9]][7] %>% trimws()
rawtext8 <- pdftext[[9]][8] %>% trimws()
rawtext9 <- pdftext[[9]][9] %>% trimws()
rawtext10 <- pdftext[[9]][10] %>% trimws()
rawtext11 <- pdftext[[9]][11] %>% trimws()
rawtext12 <- pdftext[[9]][12] %>% trimws()
rawtext13 <- pdftext[[9]][13] %>% trimws()
rawtext14 <- pdftext[[9]][14] %>% trimws()
rawtext15 <- pdftext[[9]][15] %>% trimws()
rawtext16 <- pdftext[[9]][16] %>% trimws()
rawtext17 <- pdftext[[9]][17] %>% trimws()
rawtext18 <- pdftext[[9]][18] %>% trimws()
rawtext19 <- pdftext[[9]][19] %>% trimws()
rawtext20 <- pdftext[[9]][20] %>% trimws()
rawtext21 <- pdftext[[9]][21] %>% trimws()
rawtext22 <- pdftext[[9]][22] %>% trimws()
rawtext23 <- pdftext[[9]][23] %>% trimws()
rawtext24 <- pdftext[[9]][24] %>% trimws()
rawtext25 <- pdftext[[9]][25] %>% trimws()
rawtext26 <- pdftext[[9]][26] %>% trimws()
rawtext27 <- pdftext[[9]][27] %>% trimws()
rawtext28 <- pdftext[[9]][28] %>% trimws()
rawtext29 <- pdftext[[9]][29] %>% trimws()
rawtext30 <- pdftext[[9]][30] %>% trimws()
rawtext31 <- pdftext[[9]][31] %>% trimws()
rawtext32 <- pdftext[[9]][32] %>% trimws()
rawtext33 <- pdftext[[9]][33] %>% trimws()
rawtext34 <- pdftext[[9]][34] %>% trimws()
rawtext35 <- pdftext[[9]][35] %>% trimws()
rawtext36 <- pdftext[[9]][36] %>% trimws()
rawtext37 <- pdftext[[9]][37] %>% trimws()
rawtext38 <- pdftext[[9]][38] %>% trimws()
rawtext39 <- pdftext[[9]][39] %>% trimws()
rawtext40 <- pdftext[[9]][40] %>% trimws()
rawtext41 <- pdftext[[9]][41] %>% trimws()
rawtext42 <- pdftext[[9]][42] %>% trimws()
rawtext43 <- pdftext[[9]][43] %>% trimws()
rawtext44 <- pdftext[[9]][44] %>% trimws()
rawtext45 <- pdftext[[9]][45] %>% trimws()
rawtext46 <- pdftext[[9]][46] %>% trimws()
rawtext47 <- pdftext[[9]][47] %>% trimws()
rawtext48 <- pdftext[[9]][48] %>% trimws()
rawtext49 <- pdftext[[9]][49] %>% trimws()
rawtext50 <- pdftext[[9]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Ingleside"
past_crime_ingleside <- past_crime_sf


### TARAVAL ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[10]][1] %>% trimws()
rawtext2 <- pdftext[[10]][2] %>% trimws()
rawtext3 <- pdftext[[10]][3] %>% trimws()
rawtext4 <- pdftext[[10]][4] %>% trimws()
rawtext5 <- pdftext[[10]][5] %>% trimws()
rawtext6 <- pdftext[[10]][6] %>% trimws()
rawtext7 <- pdftext[[10]][7] %>% trimws()
rawtext8 <- pdftext[[10]][8] %>% trimws()
rawtext9 <- pdftext[[10]][9] %>% trimws()
rawtext10 <- pdftext[[10]][10] %>% trimws()
rawtext11 <- pdftext[[10]][11] %>% trimws()
rawtext12 <- pdftext[[10]][12] %>% trimws()
rawtext13 <- pdftext[[10]][13] %>% trimws()
rawtext14 <- pdftext[[10]][14] %>% trimws()
rawtext15 <- pdftext[[10]][15] %>% trimws()
rawtext16 <- pdftext[[10]][16] %>% trimws()
rawtext17 <- pdftext[[10]][17] %>% trimws()
rawtext18 <- pdftext[[10]][18] %>% trimws()
rawtext19 <- pdftext[[10]][19] %>% trimws()
rawtext20 <- pdftext[[10]][20] %>% trimws()
rawtext21 <- pdftext[[10]][21] %>% trimws()
rawtext22 <- pdftext[[10]][22] %>% trimws()
rawtext23 <- pdftext[[10]][23] %>% trimws()
rawtext24 <- pdftext[[10]][24] %>% trimws()
rawtext25 <- pdftext[[10]][25] %>% trimws()
rawtext26 <- pdftext[[10]][26] %>% trimws()
rawtext27 <- pdftext[[10]][27] %>% trimws()
rawtext28 <- pdftext[[10]][28] %>% trimws()
rawtext29 <- pdftext[[10]][29] %>% trimws()
rawtext30 <- pdftext[[10]][30] %>% trimws()
rawtext31 <- pdftext[[10]][31] %>% trimws()
rawtext32 <- pdftext[[10]][32] %>% trimws()
rawtext33 <- pdftext[[10]][33] %>% trimws()
rawtext34 <- pdftext[[10]][34] %>% trimws()
rawtext35 <- pdftext[[10]][35] %>% trimws()
rawtext36 <- pdftext[[10]][36] %>% trimws()
rawtext37 <- pdftext[[10]][37] %>% trimws()
rawtext38 <- pdftext[[10]][38] %>% trimws()
rawtext39 <- pdftext[[10]][39] %>% trimws()
rawtext40 <- pdftext[[10]][40] %>% trimws()
rawtext41 <- pdftext[[10]][41] %>% trimws()
rawtext42 <- pdftext[[10]][42] %>% trimws()
rawtext43 <- pdftext[[10]][43] %>% trimws()
rawtext44 <- pdftext[[10]][44] %>% trimws()
rawtext45 <- pdftext[[10]][45] %>% trimws()
rawtext46 <- pdftext[[10]][46] %>% trimws()
rawtext47 <- pdftext[[10]][47] %>% trimws()
rawtext48 <- pdftext[[10]][48] %>% trimws()
rawtext49 <- pdftext[[10]][49] %>% trimws()
rawtext50 <- pdftext[[10]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Taraval"
past_crime_taraval <- past_crime_sf


### TENDERLOIN ###

# Grab individual text values for Page 1
rawtext1 <- pdftext[[11]][1] %>% trimws()
rawtext2 <- pdftext[[11]][2] %>% trimws()
rawtext3 <- pdftext[[11]][3] %>% trimws()
rawtext4 <- pdftext[[11]][4] %>% trimws()
rawtext5 <- pdftext[[11]][5] %>% trimws()
rawtext6 <- pdftext[[11]][6] %>% trimws()
rawtext7 <- pdftext[[11]][7] %>% trimws()
rawtext8 <- pdftext[[11]][8] %>% trimws()
rawtext9 <- pdftext[[11]][9] %>% trimws()
rawtext10 <- pdftext[[11]][10] %>% trimws()
rawtext11 <- pdftext[[11]][11] %>% trimws()
rawtext12 <- pdftext[[11]][12] %>% trimws()
rawtext13 <- pdftext[[11]][13] %>% trimws()
rawtext14 <- pdftext[[11]][14] %>% trimws()
rawtext15 <- pdftext[[11]][15] %>% trimws()
rawtext16 <- pdftext[[11]][16] %>% trimws()
rawtext17 <- pdftext[[11]][17] %>% trimws()
rawtext18 <- pdftext[[11]][18] %>% trimws()
rawtext19 <- pdftext[[11]][19] %>% trimws()
rawtext20 <- pdftext[[11]][20] %>% trimws()
rawtext21 <- pdftext[[11]][21] %>% trimws()
rawtext22 <- pdftext[[11]][22] %>% trimws()
rawtext23 <- pdftext[[11]][23] %>% trimws()
rawtext24 <- pdftext[[11]][24] %>% trimws()
rawtext25 <- pdftext[[11]][25] %>% trimws()
rawtext26 <- pdftext[[11]][26] %>% trimws()
rawtext27 <- pdftext[[11]][27] %>% trimws()
rawtext28 <- pdftext[[11]][28] %>% trimws()
rawtext29 <- pdftext[[11]][29] %>% trimws()
rawtext30 <- pdftext[[11]][30] %>% trimws()
rawtext31 <- pdftext[[11]][31] %>% trimws()
rawtext32 <- pdftext[[11]][32] %>% trimws()
rawtext33 <- pdftext[[11]][33] %>% trimws()
rawtext34 <- pdftext[[11]][34] %>% trimws()
rawtext35 <- pdftext[[11]][35] %>% trimws()
rawtext36 <- pdftext[[11]][36] %>% trimws()
rawtext37 <- pdftext[[11]][37] %>% trimws()
rawtext38 <- pdftext[[11]][38] %>% trimws()
rawtext39 <- pdftext[[11]][39] %>% trimws()
rawtext40 <- pdftext[[11]][40] %>% trimws()
rawtext41 <- pdftext[[11]][41] %>% trimws()
rawtext42 <- pdftext[[11]][42] %>% trimws()
rawtext43 <- pdftext[[11]][43] %>% trimws()
rawtext44 <- pdftext[[11]][44] %>% trimws()
rawtext45 <- pdftext[[11]][45] %>% trimws()
rawtext46 <- pdftext[[11]][46] %>% trimws()
rawtext47 <- pdftext[[11]][47] %>% trimws()
rawtext48 <- pdftext[[11]][48] %>% trimws()
rawtext49 <- pdftext[[11]][49] %>% trimws()
rawtext50 <- pdftext[[11]][50] %>% trimws()

# Bind those into a one-column table
past_crime_sf <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_sf <- as.data.frame(past_crime_sf)
# name the column temporarily
names(past_crime_sf) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_sf$rawtext2 <- strsplit(past_crime_sf$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_sf <- past_crime_sf %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_sf) = c("rawtext","category",
                         "skip1","this_month","skip2",
                         "skip3","skip4","skip5",
                         "last_year","year_to_date","skip7")

past_crime_sf <- past_crime_sf %>% filter(category %in% c("HOMICIDE","RAPE","ROBBERY",
                                                          "AGGRAVATED ASSAULT",
                                                          "HUMAN TRAFFICKING-SEX ACT",
                                                          "HUMAN TRAFFICKING-INVOLUNTARY SERV.",
                                                          "BURGLARY",
                                                          "LARCENY THEFT*",
                                                          "THEFT FROM VEHICLE*",
                                                          "AUTO THEFT",
                                                          "ARSON",
                                                          "TOTAL PART 1 PROPERTY CRIMES",
                                                          "TOTAL PART 1 VIOLENT CRIMES",
                                                          "TOTAL PART 1 CRIMES"))

past_crime_sf <- past_crime_sf %>% select(2,9,10)

past_crime_sf$last_year <- as.numeric(past_crime_sf$last_year)
past_crime_sf$year_to_date <- as.numeric(past_crime_sf$year_to_date)
past_crime_sf$district <- "Tenderloin"
past_crime_tenderloin <- past_crime_sf

past_crime_all <- rbind(past_crime_citywide,past_crime_central,past_crime_southern,past_crime_bayview,past_crime_mission,past_crime_northern,past_crime_park,past_crime_richmond,past_crime_ingleside,past_crime_taraval,past_crime_tenderloin)
names(past_crime_all) <- c("category","total2018_rev","total2019","district")

# save 2018-2019 annual file and rds archive
saveRDS(past_crime_all, "scripts/sf/rds/sf_crime_2019.rds")


rm(past_crime_all, past_crime_citywide,past_crime_central,past_crime_southern,past_crime_bayview,past_crime_mission,past_crime_northern,past_crime_park,past_crime_richmond,past_crime_ingleside,past_crime_taraval,past_crime_tenderloin)


