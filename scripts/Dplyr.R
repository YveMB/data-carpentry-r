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

##Mutate - allows us to add new columns 
interviews<- interviews % > % mutate (people_per_room = no_membrs/rooms)

#compute average
mean(interviews$no_membrs)

#group_by is tidyverse way of specifying a variable that distinguishes between 
#different groups.

interviews %>% group_by(village) %>%
  summarize(mean_no_membrs=mean(no_membrs))

interviews %>% group_by(village) %>%
  filter(memb_assoc=="yes") %>%
  summarize(mean_no_membrs=mean(no_membrs))

interviews %>% group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs=mean(no_membrs))

interviews %>% group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs=mean(no_membrs),
            min_members=min(no_membrs))




