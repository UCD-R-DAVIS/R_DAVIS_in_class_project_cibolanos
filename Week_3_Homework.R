### Week 3 Homework
surveys <- read.csv("data/portal_data_joined.csv")
surveys_base <- surveys [1:5000, c(6,9,13)]
surveys_base <- surveys_base[complete.cases(surveys_base),]
surveys_base$species_id <- factor(surveys_base$species_id)
surveys_base$plot_type <- factor(surveys_base$plot_type)
levels(surveys_base$species_id)
typeof(surveys_base$species_id)
class(surveys_base$species_id)
challenge_base <-surveys_base[surveys_base[,2]>150,]
challenge_base
