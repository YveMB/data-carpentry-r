## Use this file to follow along with the live coding exercises.
## The csv file containing the data is in the 'data/' directory.
## If you want to save plots you created, place them in the 'figures/' directory.
## You can create additional R files in the 'scripts/' directory.

library(tidyverse)
interviews<-read_csv("data/SAFI_clean.csv", na="NULL")

#if base R then use
interviews<-read.csv("data/SAFI_clean.csv", na="NULL", stringsAsFactors = FALSE)

#if base R can also use options 
options(stringsAsFactors = FALSE)
interviews<-read.csv("data/SAFI_clean.csv", na="NULL")


interviews
as.data.frame(interviews)
View(interviews)
head(interviews)
##inspect data 
dim(interviews) #dimension
nrow(interviews) #nunmber of rows
ncol(interviews) #number of columns, can also do head and tail. 
names(interviews) # tells you names of tehe columns
str(interviews) #gives you a brief summary of the structure of the strings 
summary(interviews) #looks at each column and summarises it 
interviews[1,1] #look at first row, first column
interviews[1:5,6] #look at row 1-5, sixth column
interviews[1,1:ncol(interviews)] ## or interviews[1, ] will give the entire row
interviews["respondent_wall_type"]#gives you just that column
interviews[,-1] #removes the column number 1

interviews_100<-as.data.frame(interviews[100,])
nrow(interviews)
tail(interviews)
interviews[nrow(interviews),]# gives the last row 
interviews_last <- interviews[nrow(interviews),] #last row all columns
interviews_middle <- interviews[nrow(interviews)/2,]# not really middle row
interviews[66,] # is the middle road
interviews_middle<-interviews[round(nrow(interviews)/2),] #round up to 66 
interviews_middle<-interviews[ceiling(nrow(interviews)/2),] # round up to 66

interviews[-(7:nrow(interviews)),] # will just give the first six rows

###Factors 
respondent_floor_type<-factor(c("earth", "cement", "cement", "earth"))

#gives two levels cement and earth
nlevels(respondent_floor_type)

# Order the levels
respondent_floor_type <-factor(respondent_floor_type, levels=c("earth", "cement"))
#change levels cement to brick
levels(respondent_floor_type)[2]<-"brick"
respondent_floor_type  

#convert back to character vector
as.character(respondent_floor_type)

#create a factor of years
year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
year_fct
as.numeric(year_fct) #doesnt work
as.numeric(as.character(year_fct)) # converts them back to actual year

as.numeric(levels(year_fct))[year_fct] #converts them back to actual year R recommended

affect_conflict<-interviews$affect_conflicts # can also do <-interviews[["affect_conflicts"]]
affect_conflict <-factor(affect_conflict)
affect_conflict
plot(affect_conflict) #because it is a factor you can plot it

affect_conflict<-interviews$affect_conflicts
affect_conflict[is.na(affect_conflict)]<-"undetermined" # change NAs
affect_conflict <-factor(affect_conflict) # then makes NA a level
levels(affect_conflict)

levels(affect_conflict)[2]<-"More than once"
# can also do
levels(affect_conflict)[levels(affect_conflict) =="more_once"]<-"More than once"

levels(affect_conflict)
affect_conflict <-factor(affect_conflict, levels=c("never", "once", 
                                                   "More than once", "frequently", "undetermined"))
plot(affect_conflict, ylim=c(0,50))
box()

str(interviews)
#useful for dealing with dates "lubridate"
library(lubridate)                        

dates<-interviews$interview_date
head(dates)
interviews$day<-day(dates) #function from the lubridate package
interviews$month<-month(dates)
interviews$year<-year(dates)
str(interviews)

#For using dplyr and tidyr
interviews<-read_csv("data/SAFI_clean.csv", na="NULL")
# select the three columns from the dataframe
select(interviews, village, no_membrs, years_liv)
#select the columns from village to rooms
select(interviews, village:rooms)
#filtering 
filter(interviews, village =="God")
