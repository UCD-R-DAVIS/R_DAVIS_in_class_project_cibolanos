getwd()
?read.csv
file_loc <- 'data/portal_data_joined.csv'
surveys <- read.csv("data/portal_data_joined.csv")
nrow(surveys)
ncol(surveys)
str(surveys)
summary.data.frame(surveys)
dim(surveys)
dim(surveys[,1:5])

#first 5 rows
surveys[1:5,]

surveys[c(1,5,24, 3001),]

cols_to_grab = c('record_id', 'year', 'day')
cols_to_grab
surveys[cols_to_grab]
head(surveys)
head(surveys, n=30000) #printing out a subset of that data frame
head(surveys [1:10,])
tail(surveys[,1])
head(surveys["genus"]) #get the metadata, what is this whole thing called #way of subsetting the data frame
head(surveys[["genus"]]) #gets the vector out to do other stuff with it #lose the metadata 

head(surveys[c("genus","species")])

surveys$genus #how you open up an object and ask for the next level of names
surveys$hindfoot_length #only one at a time for after the $


install.packages('tidyverse')
Yes
library(tidyverse)
?read_csv
t_surveys <- read_csv('data/portal_data_joined.csv')
class(t_surveys)
t_surveys
