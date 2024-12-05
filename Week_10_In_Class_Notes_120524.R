### In class notes 120524 ### 

#Review of Homework ### 

### Week 10 - Assignment 9 ###
library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
nchar(surveys$taxa)
nchar(surveys$chr)
table(surveys$taxa)

#for(i in unique(surveys$taxa)){
#mytaxon <- surveys %>% 
  #filter(taxa ==i)
  #print(i)
  #myspecies <- unique(mytaxon$species)
  #maxlength <- max(nchar(myspecies))
  #print(mytaxon %>% filter(nchar(species)==maxlength) %>% 
    #select(species) %>% unique())
#}




for(i in unique(surveys$taxa)){
  chosentaxon <- surveys[surveys$taxa == i,]
  longestname <- chosentaxon[nchar(chosentaxon$species) == max(nchar(chosentaxon$species)),] %>%
    select(species)
  print(paste0("The longest species name for each taxon is ",i))
  print(unique(longestname$species))
}

#part 2 use the map function to print max of each of these columns

#mycols <- mloa %>% 
  #select("windDir",
#         "windSpeed_m_s",
#         "baro_hPa",
#         "temp_C_2m",
#         "temp_C_10m",
#         "temp_C_towertop",
#        "rel_humid", 
#        "precip_intens_mm_hr")
#mycols %>% map(max)

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

maxcolumns <- mloa %>% 
  select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
maxcolumns %>% 
  map(max, na.rm=T) #windDir=360, windSpeed_m_s=20.5, baro_hPa=-999.9 #possible NA, #temp_C_2m 18.9, 20m =16.9, towertop = 16.2, rel_humid = 138, precip_intens_mm_hr = 60)

#part 3
#make a function C_to_F
#multiply celsius by 1.8 then add 32
#make 3 new columns called temp_F_2m, temp_F_10m, temp_F_towertop

C_to_F <- function(x){
  x*1.8 + 32
}

#mutate
#mloa <- mloa %>% 
  #mutate(temp_F_2m = C_to_F(temp_C_2m),
  #       temp_F_10m = C_to_F(temp_C_10m),
  #       temp_F_towertop = C_to_F(temp_C_towertop))

#mloa$newcolumn <- C_to_F(mloa$temp_C_2m)


mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)

#bonus using map_df
newmloa <- mloa %>% 
  select("temp_C_2m",
         "temp_C_10m",
         "temp_C_towertop") %>% 
  map_df(.,C_to_F) %>% 
  rename("temp_F_2m"="temp_C_2m",
         "temp_F_10m"="temp_C_10m",
         "temp_F_towertop"="temp_C_towertop") %>% 
  bind_cols(mloa)
view(newmloa)


#challenge
#use lapply to make new column that includes genus + species

surveys %>% mutate(genusspecies=lapply(
  1:nrow(surveys), function(i){
    paste0(surveys$genus[i]," ", surveys$species[i])
  }
))


#library(stringr)
#str_replace("temp_F_2m","_F_","_C_") -> changes it to "temp_C_2m"

#download cloud? in cursor

