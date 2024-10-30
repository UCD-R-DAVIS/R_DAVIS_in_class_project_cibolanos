library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

surveys_wide <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(genus, plot_type) %>%
  summarize(mean_hindfootlength = mean(hindfoot_length)) %>%
  pivot_wider(names_from = 'plot_type',values_from = 'mean_hindfootlength') %>%
  arrange(Control)

head(surveys_wide)

summary(surveys$weight) #small will be less than or equal to 20.00, medium is between 20.00-48.00, large is greater than or equal to 48.00

weight_cat <- surveys %>% 
  mutate(weight = case_when(
    weight >= 48.00 ~ "large", 
    weight > 20.00 & weight < 48.00 ~ "medium",
    weight <= 20.00 ~ "small"
  ))

table(weight_cat$weight)

surveys %>%
  mutate(weight_cat = ifelse(weight <= 20.00, "small",
                             ifelse(weight > 20.00 & weight < 48.00, "medium",
                                    "large")))
table(weight_cat$weight)
