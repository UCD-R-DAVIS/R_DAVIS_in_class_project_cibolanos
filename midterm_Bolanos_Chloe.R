#midterm_Bolanos_Chloe
#Task 1
activity_laps <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv") 
table(activity_laps$sport)

#Task 2
activity_laps2 <- activity_laps %>%
  filter(sport == "running")

#Task 3
table(activity_laps2$sport)
table(activity_laps2$minutes_per_mile)
str(activity_laps2)

activity_laps3 <- activity_laps2 %>%
  filter(minutes_per_mile < 10.00 & minutes_per_mile > 5.00) %>%
  filter(total_elapsed_time_s > 60) #in seconds not minutes

str(activity_laps3)

#Task 4
activity_laps4 <- activity_laps3 %>%
  mutate(pace_cat = case_when(
    minutes_per_mile < 6 ~ "fast", 
    minutes_per_mile >= 6 & minutes_per_mile < 8 ~ "medium",
    minutes_per_mile >8 ~ "slow"
    ))

table(activity_laps4$pace_cat)

activity_laps5 <- activity_laps4 %>%
  mutate(year_cat = case_when(
    year == 2024 ~ "new form",
    year < 2024 ~ "old form"
  ))
table(activity_laps5$year_cat)

#Task 5
activity_laps5 %>%
  group_by(year_cat, pace_cat) %>%
  summarize(avg_spm = mean(steps_per_minute)) %>%
  pivot_wider(id_cols = year_cat, 
              values_from = avg_spm,
              names_from = pace_cat) %>%
  select(year_cat, slow, medium, fast)

#Task 6
activity_laps6 <- activity_laps5 %>%
  filter(year_cat=="new form") %>%
  mutate(months= ifelse(month %in% 1:6,
                        "January-June 2024","July-October 2024")) %>%
  group_by(months) %>%
  summarize(
    min_spm = min(steps_per_minute),
    mean_spm = mean(steps_per_minute),
    med_spm = median(steps_per_minute),
    max_spm = max(steps_per_minute))
tibble(activity_laps6)
