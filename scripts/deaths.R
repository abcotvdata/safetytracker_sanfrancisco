library(tidyverse)
library(readxl)


# saveRDS(deaths,"scripts/rds/death_rates.rds")

# deaths <- readRDS("scripts/rds/death_rates.rds")

deaths <- read_excel("data/source/health/deaths.xlsx") 
deaths <- deaths %>% filter(state=="NY")
deaths$Homicide <- murders_city$rate_last12
write_csv(deaths,"data/source/health/death_rates.csv")
