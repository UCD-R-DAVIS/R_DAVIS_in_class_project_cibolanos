### Week 9 In Class Notes ###
# Homework Review # 

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")


library(tidyverse)
library(lubridate)


tz(mloa) #UTC

head(mloa)
glimpse(mloa)
class(mloa)

table(mloa$rel_humid) #-99
table(mloa$temp_C_2m) #-999.9
table(mloa$windSpeed_m_s) #-99.9

mloa2 = mloa %>% 
  filter(rel_humid !=-99) %>% 
  filter(temp_C_2m != -999.9) %>% 
  filter(windSpeed_m_s != -99.9) %>% 
  mutate(datetime=ymd_hm(paste(year,"-",
                               month,"-",
                               day," ",
                               hour24, ":",
                               min),
                         tz="UTC")) %>% 
  mutate(datetimeLocal=with_tz(datetime,tz="Pacific/Honolulu"))

tz(mloa2$datetimeLocal)

library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)

mloa2 %>% 
  mutate(localMonth= month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>% 
  group_by(localMonth,localHour) %>% 
  summarize(meantemp=mean(temp_C_2m)) %>% 
  ggplot(aes(x=localMonth,
             y=meantemp)) +
  geom_point(aes(color=localHour)) +
  scale_color_distiller(palette = "Oranges") + #distiller for discrete
  xlab("Month") +
  ylab("Mean temp (degrees C)")
?scale_color_brewer

#another way(s) (he did it very different way_)
#ggplot(daya=mloa2,aes(x=month, y=mean_hourly_temp,color=hour_hst))
#scale_color_gradient2(low='blue',high='blue',mid='white')

install.packages('khroma')
library(khroma)
?khroma


### Iterations ###

# Iteration ---------------------------------------------------------------

# Learning Objectives: 
## Understand when and why to iterate code
## Be able to start with a single use and build up to iteration
## Use for loops, apply functions, and purrr to iterate
## Be able to write functions to cleanly iterate code

# Data for class 
head(iris)
head(mtcars)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

# Packages
library(tidyverse)


# Subsetting refresher
## column of data
head(iris[1]) # first column
head(iris %>% select(Sepal.Length))

## vector of data
iris[[1]] # first column in a vector
iris[,1]
head(iris$Sepal.Length)

## specific values
iris[1,1]
iris$Sepal.Length[1]


# For Loops ---------------------------------------------------------------
## Comparison of Function & Iteration Syntax -----
test <- function(i){
  print(i)
}
test(1)

# iteration
for(i in 1:10){
  print(i)
}


## Vector example -----
## 1. What do I want my output to be?
# we want an empty vector to fill up with values from our function
results <- rep(NA, nrow(mtcars)) # can run nrow() to see what to expect
results 

## 2. What is the task I want my for loop to do?
mtcars$wt*100

## 3. What values do I want to loop through the task?
for(i in 1:nrow(mtcars)){ # we want to do this for every row in cars data, we could hard code but more robust to soft code
  results[i] <- mtcars$wt[i]*100
}



## Datafame example -----
for(i in unique(gapminder$country)){
  country_df <- gapminder[gapminder$country == i, ]
  df <- country_df %>%
    summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  return(df)
} # And when we use the return function?? one in our environmen


# how do we know for sure that the for loop is evaluting every country?
for(i in unique(gapminder$country)){
  country_df <- gapminder[gapminder$country == i, ]
  df <- country_df %>%
    summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  print(df)
} 



gapminder %>% 
  group_by(country) %>% 
  summarize(meanGDP = mean(gdpPercap, na.rm=TRUE)) %>% 
  head()
## Changing the format so that it will save all the values as a data frame
## 1. What do I want my output to be?


## 2. What is the task I want my for loop to do?


## 3. What values do I want to loop through the task?




# Map Family of Functions -----------------------------------------------------------
# map functions are useful when you want to do something across multiple columns
library(tidyverse)
# two arguments: the data & the function
# think about output, but instead of creating a blank output, you can just use the specific function

# basic function
map(iris, mean) # warning of NA for species
# default is that the output is a list

map_df(iris, mean) # df in, df out, anything that follows the function is the desired output

map_df(iris[1:4], mean) # use subset to be a little more specific & select just columns with continuous data

# class coercion



# often times iteration is paired with custom functions
head(mtcars)
print_mpg <- function(x, y){
  paste(x, "gets", y, "miles per gallon")
}


# more detailed functions which can take two arguments

map2_chr(rownames(mtcars),mtcars$mpg,print_mpg)

# Can also embed an "anonymous" function 

map2_chr(rownames(mtcars), mtcars$mpg, function(x, y)
  paste(x,"gets",y,"miles per gallon"))



# pmap for more than two inputs



### Part 2 of Class ###

if(!requireNamespace("remotes")) {
  install.packages("remotes")
}
