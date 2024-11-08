###Assignment 6###

library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

# Task 1 #
gapminder %>%
  group_by(continent,year) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  ggplot() +
  geom_point(aes(x=year,y=mean_lifeExp,color=continent)) +
  geom_line(aes(x=year,y=mean_lifeExp,color=continent))

# Task 2 #
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#I think that the scale_x_log10() line of code is making the scale logarithmic with a base of 10
#In this code geom_smooth is creating a dashed line of the linear regression as a linear model