### Week 9 Assignment 8 ###
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
