## Use this file to follow along with the live coding exercises.
## The csv file containing the data is in the 'data/' directory.
## If you want to save plots you created, place them in the 'figures/' directory.
## You can create additional R files in the 'scripts/' directory.

library(tidyverse)
interviews<-read_csv("data/SAFI_clean.csv", na="NULL")
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

