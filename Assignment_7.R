library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

str(gapminder)

table(gapminder$year)

graph <- gapminder %>% 
  select(country, continent, year, pop) %>% 
  filter(year>2000) %>%
  pivot_wider(names_from=year, values_from=pop) %>% 
  mutate(population_change = `2007`-`2002`) #make sure to use ticks because numbers in column are weird in R
str(graph)

?facet_wrap 

graph %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x=reorder(country, population_change), y=population_change)) + geom_col(aes(fill=continent)) +
  facet_wrap(~continent, scales="free") + #separates the graph by continent
  theme_clean() +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle=45,hjust=1),legend.position="none") +
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007") +
  scale_fill_brewer(palette = "Set2")
