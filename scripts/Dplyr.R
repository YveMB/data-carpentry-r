interviews<-read_csv("data/SAFI_clean.csv", na="NULL")
library(tidyverse)
dplyr::filter(interviews, village =="God")
dplyr::filter(interviews, no_membrs > 2)
str(interviews)

interviews_god<-select(filter(interviews, village=="God"), no_membrs, years_liv)
interviews_god<-interviews % > % filter(village=="God")% >%
  select(no_membrs, years_liv)

## Using pipes, subset the interviews data to include interviews where 
#respondents were members of an irrigation association (memb_assoc) and 
#retain only the columns affect_conflicts, liv_count, and no_meals.

interviews_members <- interviews %>%
  filter(memb_assoc == "yes") %>%
  select(affect_conflicts, liv_count, no_meals)