### Week 6.1: Data Visualization Pt.1a (Intro to ggplot, Boxplots)

install.packages("ggplot2")
library(ggplot2)

surveys_complete <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.)) #want generally all NAs to be gone
  
# Syntax for ggplot
## ggplot(data = <DATA>, mapping = aes(<MAPPING>)) + <GEOM_FUNCTION>() #data is where you would actually name the data frame, mapping is where you'll put the specific column names. Geom function is what will basically add the graphical representation of the data to your plot

#Example
ggplot(data=surveys_complete)

# Add aes argument
ggplot(data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length))

# Add geom_function
#if you have two continuous variables that you want to plot you could use geom_point to basically represent a point
#you could also use geom_line to show a relationship between these two variables
#if you have a situation where you have a categorical variable and a numerical variable you could use like geom_boxplot
#if you just have categorical variables you can use geom_bar

ggplot(data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point()

# Add more plot elements
# Add transparency to the points
ggplot(data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point(alpha = 0.1)

# add color to the points
ggplot(data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point(color = "blue")

# color by group
ggplot(data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point(aes(color = genus)) +
  geom_smooth(aes(color = genus)) 

#universal plot setting
ggplot(data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length, color = genus)) + 
  geom_point() +
  geom_smooth() 

# boxplot: categorical x continuous data ---
ggplot(data=surveys_complete, mapping = aes(x=species_id, y=weight)) + 
  geom_boxplot(color="orange")
#gives a summary of the spread of the continuous data for weight for each species ID
ggplot(data=surveys_complete, mapping = aes(x=species_id, y=weight)) + 
  geom_boxplot(fill="orange") + 
  geom_jitter(color="black", alpha=0.1) #to fill the inside #geom_jitter basically spreads out how the points are put onto the plot

#change the order of plot construction
ggplot(data=surveys_complete, mapping = aes(x=species_id, y=weight)) + geom_jitter(color="black", alpha=0.1) +
  geom_boxplot(fill="orange",alpha=0.5)

### Week 6.2: Data Visualization Pt 1b (Timeseries, Facets) ###
library(tidyverse)

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))

head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)

head(yearly_counts)

#to make a scatterplot
ggplot(data = yearly_counts,mapping = aes(x = year, y = n)) +
  geom_point()

#to make it a line plot
ggplot(data = yearly_counts,mapping = aes(x = year, y= n)) +
  geom_line()

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line()


ggplot(data = yearly_counts,mapping = aes(x = year, y= n, colour = species_id)) +
  geom_line() #color acts as a group

#faceting; giving each species its own separate plot
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) #by inputting a ncol or nrow will make the picture come out in the specific number of rows or columns


ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free') #you can change the scale
#scale=fixed means its the same X and Y for every faceted panel
#scale=free_x or free_Y which that's one variant not the other
#or there's free the scale will vary as a function of the N values for that species



