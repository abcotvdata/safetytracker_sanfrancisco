library(tidyverse)

# one time build of statewide annual file for past archival years

### tentative work to add longer-term annual data
cal_crime <- read_csv("data/source/reference/california_crime_annual.csv") %>% janitor::clean_names()

annual_homicide <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,5) %>% t %>% as.data.frame %>% select(16:37)
annual_rape <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,6) %>% t %>% as.data.frame %>% select(16:37)
annual_robbery <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,7) %>% t %>% as.data.frame %>% select(16:37)
annual_aggravatedassault <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,8) %>% t %>% as.data.frame %>% select(16:37)
annual_burglary <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,10) %>% t %>% as.data.frame %>% select(16:37)
annual_larceny <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,12) %>% t %>% as.data.frame %>% select(16:37)
annual_motorvehicletheft <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,11) %>% t %>% as.data.frame %>% select(16:37)

annual_homicide$category <- "Homicide"
annual_rape$category <- "Rape"
annual_robbery$category <- "Robbery"
annual_aggravatedassault$category <- "Aggravated Assault" 
annual_burglary$category <- "Burglary"
annual_larceny$category <- "Larceny Theft"
annual_motorvehicletheft$category <- "Motor Vehicle Theft" 

annual <- rbind(annual_homicide,annual_rape,annual_robbery,annual_aggravatedassault,annual_burglary,annual_larceny,annual_motorvehicletheft)
names(annual) <- c("total00","total01","total02","total03","total04",
                      "total05","total06","total07","total08","total09",
                      "total10","total11","total12","total13","total14","total15",
                      "total16","total17","total18","total19","total20","total21","category")
rm(annual_homicide,annual_rape,annual_robbery,annual_aggravatedassault,annual_burglary,annual_larceny,annual_motorvehicletheft)
annual <- annual %>% filter(total00 != "San Francisco" & total00 != "2000")
annual[,1:22] <- lapply(annual[,1:22], as.numeric)

sf_annual <- annual

# repeat for Oakland

annual_homicide <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,5) %>% t %>% as.data.frame %>% select(16:37)
annual_rape <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,6) %>% t %>% as.data.frame %>% select(16:37)
annual_robbery <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,7) %>% t %>% as.data.frame %>% select(16:37)
annual_aggravatedassault <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,8) %>% t %>% as.data.frame %>% select(16:37)
annual_burglary <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,10) %>% t %>% as.data.frame %>% select(16:37)
annual_larceny <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,12) %>% t %>% as.data.frame %>% select(16:37)
annual_motorvehicletheft <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,11) %>% t %>% as.data.frame %>% select(16:37)

annual_homicide$category <- "Homicide"
annual_rape$category <- "Rape"
annual_robbery$category <- "Robbery"
annual_aggravatedassault$category <- "Aggravated Assault" 
annual_burglary$category <- "Burglary"
annual_larceny$category <- "Larceny"
annual_motorvehicletheft$category <- "Motor Vehicle Theft" 

annual <- rbind(annual_homicide,annual_rape,annual_robbery,annual_aggravatedassault,annual_burglary,annual_larceny,annual_motorvehicletheft)
names(annual) <- c("total00","total01","total02","total03","total04",
                   "total05","total06","total07","total08","total09",
                   "total10","total11","total12","total13","total14","total15",
                   "total16","total17","total18","total19","total20","total21","category")
rm(annual_homicide,annual_rape,annual_robbery,annual_aggravatedassault,annual_burglary,annual_larceny,annual_motorvehicletheft)
annual <- annual %>% filter(total00 != "Oakland" & total00 != "2000")
annual[,1:22] <- lapply(annual[,1:22], as.numeric)

oakland_annual <- annual

# repeat for San Jose

annual_homicide <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,5) %>% t %>% as.data.frame %>% select(16:37)
annual_rape <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,6) %>% t %>% as.data.frame %>% select(16:37)
annual_robbery <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,7) %>% t %>% as.data.frame %>% select(16:37)
annual_aggravatedassault <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,8) %>% t %>% as.data.frame %>% select(16:37)
annual_burglary <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,10) %>% t %>% as.data.frame %>% select(16:37)
annual_larceny <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,12) %>% t %>% as.data.frame %>% select(16:37)
annual_motorvehicletheft <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,11) %>% t %>% as.data.frame %>% select(16:37)

annual_homicide$category <- "Homicide"
annual_rape$category <- "Rape"
annual_robbery$category <- "Robbery"
annual_aggravatedassault$category <- "Aggravated Assault" 
annual_burglary$category <- "Burglary"
annual_larceny$category <- "Larceny"
annual_motorvehicletheft$category <- "Motor Vehicle Theft" 

annual <- rbind(annual_homicide,annual_rape,annual_robbery,annual_aggravatedassault,annual_burglary,annual_larceny,annual_motorvehicletheft)
names(annual) <- c("total00","total01","total02","total03","total04",
                   "total05","total06","total07","total08","total09",
                   "total10","total11","total12","total13","total14","total15",
                   "total16","total17","total18","total19","total20","total21","category")
rm(annual_homicide,annual_rape,annual_robbery,annual_aggravatedassault,annual_burglary,annual_larceny,annual_motorvehicletheft)
annual <- annual %>% filter(total00 != "San Jose" & total00 != "2000")
annual[,1:22] <- lapply(annual[,1:22], as.numeric)

sj_annual <- annual

write_csv(sf_annual,"data/source/annual/sf_annual_state.csv")
write_csv(sj_annual,"data/source/reference/sj_annual_state.csv")
write_csv(oakland_annual,"data/source/reference/oakland_annual_state.csv")

#### Repeating for 
####### clearance rates

### tentative work to add longer-term annual data
# cal_crime <- read_csv("data/source/reference/california_crime_annual.csv") %>% janitor::clean_names()

annual_homicide <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,5,14) %>% filter(year>1999)
annual_rape <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,6,15) %>% filter(year>1999)
annual_robbery <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,7,16) %>% filter(year>1999)
annual_aggravatedassault <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,8,17) %>% filter(year>1999)
annual_burglary <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,10,19) %>% filter(year>1999)
annual_larceny <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,12,21) %>% filter(year>1999)
annual_motorvehicletheft <- cal_crime %>% filter(ncic_code=="San Francisco") %>% select(1,3,11,20) %>% filter(year>1999)

annual_homicide$clearance <- round((annual_homicide$homicide_clr_sum/annual_homicide$homicide_sum)*100,1)
annual_rape$clearance <- round((annual_rape$for_rape_clr_sum/annual_rape$for_rape_sum)*100,1)
annual_robbery$clearance <- round((annual_robbery$robbery_clr_sum/annual_robbery$robbery_sum)*100,1)
annual_aggravatedassault$clearance <- round((annual_aggravatedassault$agg_assault_clr_sum/annual_aggravatedassault$agg_assault_sum)*100,1)
annual_burglary$clearance <- round((annual_burglary$burglary_clr_sum/annual_burglary$burglary_sum)*100,1)
annual_larceny$clearance <- round((annual_larceny$l_ttotal_clr_sum/annual_larceny$l_ttotal_sum)*100,1)
annual_motorvehicletheft$clearance <- round((annual_motorvehicletheft$vehicle_theft_clr_sum/annual_motorvehicletheft$vehicle_theft_sum)*100,1)

annual_homicide %>% select(1,5) %>% write_csv("data/source/annual/sf_clearance_murder.csv")
annual_rape %>% select(1,5) %>% write_csv("data/source/annual/sf_clearance_sexassault.csv")
annual_robbery %>% select(1,5) %>% write_csv("data/source/annual/sf_clearance_robbery.csv")
annual_aggravatedassault %>% select(1,5)  %>% write_csv("data/source/annual/sf_clearance_aggravatedassault.csv")
annual_burglary %>% select(1,5) %>% write_csv("data/source/annual/sf_clearance_burglary.csv")
annual_larceny %>% select(1,5) %>% write_csv("data/source/annual/sf_clearance_larceny.csv")
annual_motorvehicletheft %>% select(1,5) %>% write_csv("data/source/annual/sf_clearance_autotheft.csv")

# repeat for Oakland

annual_homicide <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,5,14) %>% filter(year>1999)
annual_rape <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,6,15) %>% filter(year>1999)
annual_robbery <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,7,16) %>% filter(year>1999)
annual_aggravatedassault <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,8,17) %>% filter(year>1999)
annual_burglary <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,10,19) %>% filter(year>1999)
annual_larceny <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,12,21) %>% filter(year>1999)
annual_motorvehicletheft <- cal_crime %>% filter(ncic_code=="Oakland") %>% select(1,3,11,20) %>% filter(year>1999)

annual_homicide$clearance <- round((annual_homicide$homicide_clr_sum/annual_homicide$homicide_sum)*100,1)
annual_rape$clearance <- round((annual_rape$for_rape_clr_sum/annual_rape$for_rape_sum)*100,1)
annual_robbery$clearance <- round((annual_robbery$robbery_clr_sum/annual_robbery$robbery_sum)*100,1)
annual_aggravatedassault$clearance <- round((annual_aggravatedassault$agg_assault_clr_sum/annual_aggravatedassault$agg_assault_sum)*100,1)
annual_burglary$clearance <- round((annual_burglary$burglary_clr_sum/annual_burglary$burglary_sum)*100,1)
annual_larceny$clearance <- round((annual_larceny$l_ttotal_clr_sum/annual_larceny$l_ttotal_sum)*100,1)
annual_motorvehicletheft$clearance <- round((annual_motorvehicletheft$vehicle_theft_clr_sum/annual_motorvehicletheft$vehicle_theft_sum)*100,1)

annual_homicide %>% select(1,5) %>% write_csv("data/source/annual/oakland_clearance_murder.csv")
annual_rape %>% select(1,5) %>% write_csv("data/source/annual/oakland_clearance_sexassault.csv")
annual_robbery %>% select(1,5) %>% write_csv("data/source/annual/oakland_clearance_robbery.csv")
annual_aggravatedassault %>% select(1,5)  %>% write_csv("data/source/annual/oakland_clearance_aggravatedassault.csv")
annual_burglary %>% select(1,5) %>% write_csv("data/source/annual/oakland_clearance_burglary.csv")
annual_larceny %>% select(1,5) %>% write_csv("data/source/annual/oakland_clearance_larceny.csv")
annual_motorvehicletheft %>% select(1,5) %>% write_csv("data/source/annual/oakland_clearance_autotheft.csv")


# repeat for San Jose


annual_homicide <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,5,14) %>% filter(year>1999)
annual_rape <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,6,15) %>% filter(year>1999)
annual_robbery <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,7,16) %>% filter(year>1999)
annual_aggravatedassault <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,8,17) %>% filter(year>1999)
annual_burglary <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,10,19) %>% filter(year>1999)
annual_larceny <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,12,21) %>% filter(year>1999)
annual_motorvehicletheft <- cal_crime %>% filter(ncic_code=="San Jose") %>% select(1,3,11,20) %>% filter(year>1999)

annual_homicide$clearance <- round((annual_homicide$homicide_clr_sum/annual_homicide$homicide_sum)*100,1)
annual_rape$clearance <- round((annual_rape$for_rape_clr_sum/annual_rape$for_rape_sum)*100,1)
annual_robbery$clearance <- round((annual_robbery$robbery_clr_sum/annual_robbery$robbery_sum)*100,1)
annual_aggravatedassault$clearance <- round((annual_aggravatedassault$agg_assault_clr_sum/annual_aggravatedassault$agg_assault_sum)*100,1)
annual_burglary$clearance <- round((annual_burglary$burglary_clr_sum/annual_burglary$burglary_sum)*100,1)
annual_larceny$clearance <- round((annual_larceny$l_ttotal_clr_sum/annual_larceny$l_ttotal_sum)*100,1)
annual_motorvehicletheft$clearance <- round((annual_motorvehicletheft$vehicle_theft_clr_sum/annual_motorvehicletheft$vehicle_theft_sum)*100,1)

annual_homicide %>% select(1,5) %>% write_csv("data/source/annual/sj_clearance_murder.csv")
annual_rape %>% select(1,5) %>% write_csv("data/source/annual/sj_clearance_sexassault.csv")
annual_robbery %>% select(1,5) %>% write_csv("data/source/annual/sj_clearance_robbery.csv")
annual_aggravatedassault %>% select(1,5)  %>% write_csv("data/source/annual/sj_clearance_aggravatedassault.csv")
annual_burglary %>% select(1,5) %>% write_csv("data/source/annual/sj_clearance_burglary.csv")
annual_larceny %>% select(1,5) %>% write_csv("data/source/annual/sj_clearance_larceny.csv")
annual_motorvehicletheft %>% select(1,5) %>% write_csv("data/source/annual/sj_clearance_autotheft.csv")