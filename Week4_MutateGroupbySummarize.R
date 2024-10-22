# Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column
surveys <- surveys %>%
  mutate(weight_kg = weight/1000)
head(surveys)
str(surveys)

# Add other columns
surveys <- surveys %>% 
    mutate(.,
            weight_kg = weight/1000,
            weight_kg2 = weight_kg*2)
str(surveys)

# Filter out the NA's
ave_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(mean_weight=mean(weight))
str(ave_weight)
nrow(ave_weight) #32283

ave_weight <- surveys %>% 
  filter(complete.cases(.)) #eliminates anywhere that an NA is in your data frame
nrow(ave_weight) #30738

# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups, apply some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 

surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) 


# multiple groups
df <- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

summary(df)

# remove na's


# sort/arrange order a certain way
surveys %>%
  group_by(sex, species_id) %>%
  filter(sex !="") %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(mean_weight) #ascending

surveys %>%
  group_by(sex, species_id) %>%
  filter(sex !="") %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(-mean_weight) #descending


  
# Challenge
#What was the weight of the heaviest animal measured in each year? Return a table with three columns: year, weight of the heaviest animal in grams, and weight in kilograms, arranged (arrange()) in descending order, from heaviest to lightest. (This table should have 26 rows, one for each year)

surveys %>%
  filter(!is.na(weight)) %>%
  group_by(year) %>%
  summarize(max_weight_g = max(weight)) %>% 
  mutate(max_weight_kg = max_weight_g/1000) %>% 
  arrange(-max_weight_kg)
  

  
#test 

#Try out a new function, count(). Group the data by sex and pipe the grouped data into the count() function. How could you get the same result using group_by() and summarize()? Hint: see ?n.