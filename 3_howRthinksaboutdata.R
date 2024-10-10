# Other data types
## Lists
c(4,6,"dog")
a <- list(4,6,"dog")
class(a)
str(a)

# Data.frames
letters
data.frame(letters)
df <- data.frame(letters)
as.data.frame(t(df))
length(df) # number of columns in a data frame
dim(df) #rows, columns
nrow(df)
ncol(df)

# factors
animals <- factor(c("duck", "duck", "goose", "goose"))
animals #levels goes through alphabetically 
animals <- factor(c("pigs" , "duck", "duck", "goose", "goose"))
animals
class(animals)
levels(animals)
nlevels(animals)


animals <- factor(x = animals, levels = c("goose", "pigs", "duck")) #changes the levels #factor turn it into a set of categorical data
animals

year <- factor(c(1978,1980,1934,1979))
year
class(year)
as.numeric(year) #order of the levels 
year
