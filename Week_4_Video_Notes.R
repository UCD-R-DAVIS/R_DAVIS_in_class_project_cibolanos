### Week 4.1: Data Manipulation Part 1a

surveys <- read_csv("data/portal_data_joined.csv")
#select columns
month_day_year <- select(surveys,month,day,year) #for the function select, the first argument is the data file, and then after that you list every single column that you want to keep 

#filtering by equals
filter(surveys,year==1981) #only keep certain observations that meet logical statements

#if you want to manipulate this dataset and do stuff with it you would set it as so to create a new variable
year_1981 <- filter(surveys, year == 1981 )

#filtering by range
filter(surveys, year %in% c(1981:1983))

#filtering by multiple conditions
bigfoot_with_weight <- filter(surveys, hindfoot_length > 40 & !is.na(weight))

#multi-step process
small_animals <- filter(surveys, weight < 5) #now we created an intermediate data frame and we need to remember to select from small_animals, not surveys in the next step
small_animal_ids <- select(small_animals, record_id, plot_id, species_id)

#same process, using nested functions
small_animals_ids <- select(filter(surveys, weight < 5), record_id, plot_id, species_id)

#same process, using a pipe
#Cmd Shift M
#or |>
#note our select function no longer explicitly calls the tibble as its first element
small_animal_ids <- filter(surveys,weight<5) %>% select(record_id,plot_id,species_id)

#same as
small_animal_ids <- surveys%>% filter(weight < 5) %>% select(record_id,plot_id,species_id)

#how to do line breaks with pipes
surveys %>% filter(month==1)

#good:
  surveys %>%
    filter(month==1)
  
### Week 4.2: Data Manipulation Part 1b
  
# Mutate
  #there might be some cases where you want to create a new column of data in your data frame
surveys <- surveys %>% #pipe is %>% symbols
    mutate(weight_kg = weight/1000)
str(surveys)

# Add multiple columns
surveys <- surveys %>%
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)      

# filter out na's
surveys <- surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)

# Group_by and summarize
  # Group_by essentially allows you to perform an analysis on certain groups in your data
surveys2 <- surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean (weight))
str(surveys2)

surveys3 <- surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean (weight))
surveys3
#summarized the weight per sex

surveys3 <- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean (weight))
surveys3

#arrange 
#arrange is the function if you wanted to look at weight in ascending or descending order
surveys %>%
  group_by(sex,species_id) %>%
  summarize(mean_weight = mean(weight)) %>%
  arrange(mean_weight)
#if you wanted to look at the max weight and lower, you do the code below
surveys %>%
  group_by(sex,species_id) %>%
  summarize(mean_weight = mean(weight)) %>%  
  arrange(-mean_weight) #makes it descend from the max value

#summarize multiple values / multiple columns
surveys %>%
  group_by(sex,species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%  
  arrange(-mean_weight)