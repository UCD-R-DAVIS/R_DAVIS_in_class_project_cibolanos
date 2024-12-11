### Hi! I included the prompt parts of the final as a comment with ### (as you guys recommend we copy and paste the prompt into our script), and my own comments have a # with them to create some separation and hopefully make it easier to read. Thank you!


### Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.

library(tidyverse)
activity <- read.csv('https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv')

head(activity)
str(activity)
table(activity$sport)

###Filter out any non-running activities.

activity2 <- activity %>% 
  filter(sport == "running")

table(activity2$sport) #to check that the sport is only running

### We are interested in normal running. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.

str(activity2$minutes_per_mile)

activity3 <- activity2 %>% 
  filter(minutes_per_mile < 10.00 & minutes_per_mile > 5.00) %>%
  filter(total_elapsed_time_s > 60)

max(activity3$minutes_per_mile) #9.97 so the filtering worked here
min(activity3$minutes_per_mile) #5.006 so the filtering worked here as well
min(activity3$total_elapsed_time_s) #60.043 so the filtering worked for everything!

###Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.

head(activity4)

head(activity4$running) #I was not seeing what i wanted to see when i was trying to check if my datetime function worked, but i was able to go into the environment and verify that the datetime & ymd code worked

activity4 <- activity3 %>% 
  mutate(datetime=ymd(paste(year,"-",
                               month,"-",
                               day," ")))

activity5 <- activity4 %>% 
  mutate(timeperiod = case_when(
    year < 2024 ~ 'Pre-2024 Running',
    datetime >= "2024-01-01" & datetime<= "2024-06-30" ~ 'Initial Rehab Efforts',
    datetime >= "2024-07-01" ~ 'Post Rehab'
  ))

head(activity5) # I viewed activity 5 in the environment to make sure everything was working



###Make a scatter plot that graphs SPM over speed by lap.
###Make 5 aesthetic changes to the plot to improve the visual.
###Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())

library("RColorBrewer")
display.brewer.all()

ggplot(activity5, aes(x=minutes_per_mile, y= steps_per_minute, color=timeperiod)) +
  geom_point(alpha=0.5) +
  geom_smooth(method="lm", se=FALSE, aes(group=timeperiod), linetype="solid") +
  labs(
    title= "Steps per Minute vs Minutes per Mile",
    x= "Minutes per Mile",
    y= "Steps per Minute",
    color="Time Period"
  ) +
  scale_color_brewer(palette="Dark2") +
  theme_classic() +
  theme(
    axis.text = element_text(size=14, face = "italic", color="blue"),
    axis.title = element_text(size=14, face = "italic" , color= "turquoise"),
    plot.title = element_text(size=16, face= "bold", hjust = 0.5),
    legend.position="top",
    panel.grid.major = element_line(color= "gray", linewidth =0.3),
    panel.grid.minor = element_line(color="gray", linewidth=0.1)
  )



?scale_color_brewer #I was using a different set and it was not showing up well
# I tried to do the graph by timestamp but it looked crazy and i could not get it to work unfortunately

###Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).

head(activity5)
view(activity5)
table(activity5$timeperiod)

post_rehab <-activity5 %>% 
  filter(timeperiod=="Post Rehab") #to make a data frame that is just post-intervention

table(post_rehab$timeperiod) #to make sure it worked

post_rehab2 <- post_rehab %>% 
  mutate(date=datetime) %>% 
  group_by(date) %>% 
  mutate(lap_number = rank(datetime)) %>% 
  filter(lap_number <= 3) %>% 
  ungroup()
  

head(post_rehab2) #to make sure the above code worked

ggplot(post_rehab2, aes(x=minutes_per_mile, y=steps_per_minute, color= lap_number)) +
  geom_point(alpha = 1) +
  geom_smooth(method="lm", se=FALSE, aes(group=lap_number), linetype="solid",linewidth=1)
  labs(
    title= "Steps per Minute vs Minutes per Mile for Post-Rehab Runs",
    x= "Miles per Minute",
    y= "Steps per Minute",
    color = "Lap Number"
  ) + theme_classic()

# The relationship changes as Tyler gets tired, with there being less steps per minute and an increase minutes per mile as the lap numbers increase. In summary, as Tyler gets more tired he slows down

  
# Thank you guys so much for a great class! #

  

