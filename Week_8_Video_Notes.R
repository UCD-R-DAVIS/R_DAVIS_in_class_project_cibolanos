### Week 8 Video Notes ###
# Week 8.1: Lubridate #

#three time classes
#Dates
#posixct (calendar time)
#posixlt (local time)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", 
                    "2019-01-01", "2019-02-18")

class(sample_dates_1)

#as far as R knows, these are just words.
#To convert it into a date object, we start with that character vector and do a transformation
#so we take those sample dates that we just created, and run as.Date on them

#The string must be of the form
#YYYY-MM-DD
#to convert it into a Date object
sample_dates_1 <- as.Date(sample_dates_1)

class(sample_dates_1)

#otherwise this happens:
sample_dates_2 <- c("02-01-2018", "03-21-2018", 
                    "10-05-2018", "01-01-2019", "02-18-2019")
sample_dates_3 <-as.Date(sample_dates_2) # this doesn't work

sample_dates_3

#to fix this error, you need to specify the format like so:
sample_dates_3<- as.Date(sample_dates_2, format = "%m-%d-%Y" ) 
# date code preceded by "%"
# you use a percent to show that you have a symbol that you want parsed. m is for month
sample_dates_3


#here is a complete list of date-time formats
?strptime

#challenge
as.Date("Jul 04, 2019", format = 
          "%b%d,%Y") #b is for the abbreviated month name


#when working with times, POSIXct is the best class to work with
tm1 <- as.POSIXct("2016-07-24 23:55:26")
tm1

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2 #make sure your % stuff is matching the format of the data. Before we had commas between them because the numbers did, but in this example there is no separation so the % stuff does not need to be separated 


#posixct assumes you collected your data in the 
#timezone your computer is set to. 
#To change this, set the timezone parameter. 
#Here's an example that sets the timezone to "GMT"
tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3



#the tidyverse way:
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2018-03-21", 
                    "2018-10-05", "2019-01-01", "2019-02-18")
#we use ymd since our data is y-m-d
sample_dates_lub <- ymd(sample_dates_1)

sample_dates_lub


sample_dates_2 <- c("2-01-2018", "3-21-2018", 
                    "10-05-18", "01-01-2019", "02-18-2019")
#notice that not all of the expected number of 
#digits are always used. Lubridate don't care!

sample_dates_lub2 <- mdy(sample_dates_2)
sample_dates_lub2


#more examples using lubridate:
lubridate::ymd("2016/01/01")# --> 2016-01-01
lubridate::ymd("2011-03-19")# --> 2011-03-19
lubridate::mdy("Feb 19, 2011")# --> 2011-02-19 #don't need to worry about the month abbreviation, lubridate can read it
lubridate::dmy("22051997")# --> 1997-05-22

#Timezones:
#hms means hours, minutes seconds. 
#to add time to a date, use functions that 
#add "_hms" or "_hm"
#it's a good idea to combine your date and 
#time into a single column, since
#it represents different sized increments 
#of a single time variable

lubridate::ymd_hm("2016-01-01 12:00", 
                  tz="America/Los_Angeles")
# --> 2016-01-01 12:00:00
#24 hour time:
lubridate::ymd_hm("2016/04/05 14:47", 
                  tz="America/Los_Angeles")
# --> 2016-04-05 14:47:00

#converts 12 hour time into 24 hour time:
latime <- lubridate::ymd_hms("2016/04/05 4:47:21 PM", 
                             tz="America/Los_Angeles")  #have to use PM for it to convert into 24 hour time
latime
#how to change time zones
with_tz(latime, tzone = "GMT")
with_tz(latime, tzone = "Pacific/Honolulu")
# --> 2016-04-05 16:47:21

#make sure your data starts as 
#character strings, not as dates and times, 
#before converting to lubridate
#read_csv will see dates and 
#times and guess that you want them as 
#Date and Time objects, so you have to 
#explicitly tell it not to do this.

library(dplyr)
library(readr)

# read in some data and skip header lines
mloa1 <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
head(mloa1) #R tried to guess for you that 
#the year, month, day, and hour columns were numbers

# import raw dataset & specify column types
mloa2 <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv",
                  col_types = "cccccccddddddddd") #c is for character, d is for double (which is a number?)

#notice the difference in the data types of these two objects:
glimpse(mloa1) 
glimpse(mloa2)

# now we are ready to make a datetime col 
#so that we can use lubridate on it:
mloa2$datetime <- paste(mloa2$year, "-", mloa2$month,
                        "-", mloa2$day, ", ", mloa2$hour24, ":",
                        mloa2$min, sep = "")

glimpse(mloa2)
#since we used "paste," our new column is a character string type

# there are 3 options for how to progress from here:
# convert Date Time to POSIXct in local timezone using lubridate

#WARNING!!
#this method as_datetime does not work 
#in this dataset unless you specify
#format, because otherwise it tries to look for 
#seconds but we don't have data for seconds, 
#and there are an inconsistent number of 
#digits for each portion of the datetime 
#(eg month could be "2" or "12")
mloa2$datetime_test <- as_datetime(mloa2$datetime, 
                                   tz="America/Los_Angeles", 
                                   format="%Y-%m-%d, %H:%M")
#note: America/Los_Angeles is not actually 
#the time zone that this data is from,
#which is evident because when telling 
#lubridate to assume the data is from 
#America/Los_Angeles, the 60 datapoints 
#during the switch to daylight savings 
#are parsed as "NA" because that hour didn't actually exist!

# Instead, convert using the ymd_functions
#This method works!
mloa2$datetime_test2 <- ymd_hm(mloa2$datetime, 
                               tz = "Pacific/Honolulu")

# OR wrap in as.character()
mloa1$datetime <- ymd_hm(as.character(mloa2$datetime), 
                         tz="Pacific/Honolulu")
tz(mloa1$datetime)

#how do we extract different components from a lubridate object?
# Functions called day(), month(), year(), 
#hour(), minute(), second(), etc... will 
#extract those elements of a datetime column.
months <- month(mloa2$datetime)

# Use the table function to get a quick 
#summary of categorical variables
table(months)

# Add label and abbr agruments to convert 
#numeric representations to have names
months <- month(mloa2$datetime, label = TRUE, abbr=TRUE)
table(months)

#how to check for daylight savings time
dst(mloa2$datetime_test[1])
dst(mloa2$datetime)

latime <- lubridate::ymd_hms("2016/04/05 4:47:21 PM", 
                             tz="America/Los_Angeles") 
latime
dst(latime)
gm <- with_tz(latime, tzone = "GMT") #with tz converting time zones
dst(gm) 
hi <- with_tz(latime, tzone = "Pacific/Honolulu")
dst(hi) 
# --> 2016-04-05 16:47:21

# Week 8.2: Function Writing #

# Creating Functions

## Defining a function 
#in the function we need to specify arguments as the input, and then the output will be some sort of value

my_sum <- function (a,b){
  the_sum <- a + b
  return(the_sum)
}

my_sum
my_sum(a=2,b=2)

sum <- my_sum(a=2,b=2)

#provide default values
my_sum2 <- function (a=1,b=2){
  the_sum <- a + b
  return(the_sum)
}

my_sum2()
my_sum2(b=3) #changing b to 3

## Process to write your own function

## temperature to conversion example: Farenheit to Kelvin
((50-32) * (5/9)) + 273.15

## How to write functions:
# 1. Identify what piece(s) will change within your commands -- this is your argument
# 2. Remove it and replace with object(s) name(s)
# 3. Place code and argument into the function() function

f_to_k <- function(tempF){
((tempF-32) * (5/9)) + 273.15  
}

f_to_k(tempF=72)

f_to_k <- function(tempF){
  k <- ((tempF-32) * (5/9)) + 273.15
  return(k)
}

f_to_k(tempF=72)
# pass by functions -> what happens in a function stays in a function

## Using dataframes in functions
# calculate average GDP in a given country, in a given span of years, using the gapminder data

library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")


# write a specific line of code to calc average

gapminder %>% 
  filter(country == "Canada", year %in% c(1950:1970)) %>% 
  summarize(meanGDP= mean(gdpPercap, na.rm = TRUE))


# generalize the code
## what we need to change in order to generalize this is the specific country & range of years

avgGDP <- function(cntry, yr.range){
  df <- gapminder %>% 
    filter(country == cntry, year %in% c(yr.range)) %>% 
    summarize(meanGDP= mean(gdpPercap, na.rm = TRUE))
  return(df)
  }

avgGDP("United States", 1980:1995)









