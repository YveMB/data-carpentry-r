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

#Count
interviews %>% count(village)
interviews %>% count(village, sort=TRUE) #will arrange from highest to lowest

#Use group_by() and summarize() to find the mean, min, and max number of household members for each village. Also add the number of observations (hint: see ?n).
interviews %>% group_by(village) %>%
  summarize(mean_no_membrs=mean(no_membrs),
            min_members=min(no_membrs),
            max_members=max(no_membrs), n=n())

#reshaping in tidyverse 
interviews<-interviews %>% mutate(wall_type_logical=TRUE) %>%
  spread(key=respondent_wall_type, value = wall_type_logical, fill=FALSE)

interviews <- interviews %>% gather (key=respondent_wall_type, 
                                     value = "wall_type_logical", 
                                     burntbricks:sunbricks)

#prepare data for graphing
# splitting the multiple data in the items owned col.
interviews<-read_csv("data/SAFI_clean.csv", na="NULL")
interviews_plotting <- interviews %>%
  mutate(split_items = strsplit(items_owned,";")) %>%
  unnest () %>%
  mutate(items_owned_logical=TRUE) %>%
  spread(key=split_items, value=items_owned_logical, fill=FALSE) %>%
  rename(no_listed_items="<NA>")%>%
  mutate(split_months=strsplit(months_lack_food, ";")) %>%
  unnest() %>%
  mutate(months_lack_food_logical=TRUE) %>%
  spread(key=split_months, value=months_lack_food_logical, fill=FALSE) %>%
  mutate(number_month_lack_food=rowSums(select(.,April:Sept))) %>%
  mutate(number_items=rowSums(select(.,bicycle:television)))

write_csv(interviews_plotting, path="data_output/interviews_plotting.csv")

interviews_plotting<-read_csv("/Users/User/Desktop/interviews_plotting.csv")

library(ggplot2)
ggplot(data=interviews_plotting, 
       aes(x=no_membrs, y=number_items))+
  geom_point(alpha=0.5)

ggplot(data=interviews_plotting, 
       aes(x=no_membrs, y=number_items))+
  geom_jitter(alpha=0.5)

ggplot(data=interviews_plotting, 
       aes(x=no_membrs, y=number_items))+
  geom_jitter(alpha=0.5, color="blue")


ggplot(data=interviews_plotting, 
       aes(x=no_membrs, y=number_items))+
  geom_jitter(aes(color=village), alpha=0.5)

ggplot(data=interviews_plotting, 
       aes(x=village, y=rooms))+
  geom_jitter(aes(color=respondent_wall_type))

ggplot(data=interviews_plotting,
       aes(x=respondent_wall_type, y=rooms))+
  geom_boxplot()

ggplot(data=interviews_plotting,
       aes(x=respondent_wall_type, y=rooms))+
  geom_boxplot(alpha=0)+
  geom_jitter(alpha=0.5, color="tomato")+
  ylab("Rooms")+
  xlab("Wall Type")+
  labs(caption="Fig. 1. African number of rooms and wall types")+
  theme(plot.caption=element_text(size=8, hjust=-0, lineheight=0.9))+
  theme(axis.line.x=element_line(color="black", size=0.5), axis.line.y=element_line(color="black", size=0.5))+
  theme(panel.background=element_blank())

