### Week 5.1: Data Manipulation Part 2a - Conditional Statements

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

summary(surveys$hindfoot_length)
#psuedocode
#ifelse(test or condition, what to do if the test is yes/true, what to do if its false/no)

#boolean test
surveys$hindfoot_length<29.29

#creating a new column, pulling up the data frame and setting a new column; cat is for categorical

surveys$hindfoot_cat <-ifelse(surveys$hindfoot_length<29.29, yes="small", no="big")
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length) #original column

#below, the way of specifying the condition will in theory give us the exact same result
surveys$hindfoot_cat <-ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE), yes="small", no="big")
head(surveys$hindfoot_cat) #just another way to set the conditional statement

#case_when() a function that allows you to set as many arguments as you need or tests that you want to do
surveys %>% #use mutate to specify the new column
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", #if hindfoot length is bigger than 29.29, label it big
    is.na(hindfoot_length) ~ NA_character_, #Rs way of know that this value is NA and because this vector is a character, NA is also going to be a character
    TRUE ~ "small" #but if its not, lets label it small #captures everything else that isnt labeled as big; essentially the else part
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()

#more categories? 
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big", 
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, 
    TRUE ~ "small"
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  group_by(hindfoot_cat) %>%
  tally()

#overall really useful when you need to classify or reclassify data; case_when function is super useful if you have a lot of different conditions that you want to be able to set these classifications for in your data

### Week 5.2: Data Manipulation Part 2b - Joins, Pivots
#joining is about bringing data frames together; example is combining data frame A and data frame B
#pivoting is i have a long data frame i want to make it wide; so going from lots of rows to lots of columns or vice versa

library(tidyverse)

tail <- read_csv('data/tail_length.csv')
head(tail)
dim(tail) 

# pseudocode: join_function(data frame a, data frame b, how to join)

surveys <- read_csv('data/portal_data_joined.csv')

# inner_join(data frame a, data frame b, common id) -> if the ID value is in data frame A and data frame B it will match, merge, and then get rid of any record IDs that are not in both A and B 
# inner_join only keeps records that are in both data frames

dim(inner_join(x = surveys,y = tail,by = 'record_id'))
dim(surveys)
dim(tail)

# left_join
# left_join takes dataframe x and dataframe y and it keeps everything in x and only matches in y
#left_join(x, y) == right_join(y, x)
# right_join takes dataframe x and dataframe y and it keeps everything in y and only matches in x
#right_join(x, y) == left_join(y, x)

surveys_left_joined <- left_join(x = surveys, y = tail, by = 'record_id')
surveys_right_joined <- right_join(y = surveys, x = tail, by = 'record_id')

dim(surveys_left_joined)
dim(surveys_right_joined)


# full_join(x,y)
# full_join keeps EVERYTHING #any case where there was no record ID in that tail data frame its going to put an NA for tail length. So you create NA where you dont have a merged value
surveys_full_joined <- full_join( x = surveys, y = tail)
dim(surveys_full_joined)
 
# pivot_wider makes data with more columns
pivot_wider()

# pivot_longer makes data with more rows
pivot_longer

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% #filtering out NA weight values 
  group_by(genus, plot_id) %>% #grouping by genus and plot id
  summarize(mean_weight = mean(weight)) #then summarizing the mean weight by genus and plot id

surveys_mz # we now have a column for genus, plot id, and mean weight
unique(surveys_mz$genus)

wide_survey <- surveys_mz %>%
  pivot_wider(names_from = 'plot_id',values_from = 'mean_weight') #names from means we're taking the column names from a given variable; value from is what values are we filling in for the column names 

head(wide_survey)

surveys_long <- wide_survey %>% pivot_longer(-genus, names_to = 'plot_id', values_to = 'mean_weight') #we want the genus to stay where it was

head(surveys_long)

wide_survey %>% pivot_longer(-genus, names_to = 'plot_id') #you'll get the same as the code below, but the column will be values instead of mean weight because it wasnt specified


wide_survey %>% pivot_longer(-genus, names_to = 'plot_id',values_to = 'mean_weight')








