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