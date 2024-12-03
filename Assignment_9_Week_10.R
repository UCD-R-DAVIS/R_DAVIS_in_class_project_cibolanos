### Week 10 - Assignment 9 ###
library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
nchar(surveys$taxa)
nchar(surveys$chr)
table(surveys$taxa)

for(i in unique(surveys$taxa)){
  chosentaxon <- surveys[surveys$taxa == i,]
  longestname <- chosentaxon[nchar(chosentaxon$species) == max(nchar(chosentaxon$species)),] %>%
    select(species)
  print(paste0("The longest species name for each taxon is ",i))
  print(unique(longestname$species))
}

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

maxcolumns <- mloa %>% 
  select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
maxcolumns %>% 
  map(max, na.rm=T) #windDir=360, windSpeed_m_s=20.5, baro_hPa=-999.9 #possible NA, #temp_C_2m 18.9, 20m =16.9, towertop = 16.2, rel_humid = 138, precip_intens_mm_hr = 60)

C_to_F <- function(x){
  x*1.8 + 32
}

mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)

# Thank you for a great class! #
