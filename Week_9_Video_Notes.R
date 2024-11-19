### Week 9.1: For Loops

# Iteration
# Learning Objectives:
## Understand when and why to iterate code
## Be able to start with a single use and build up to iteration
## Use for loops and map functions to iterate

# Data Upload

head(iris)
head(mtcars)

# Subsetting refresher
# square brackets for indexing
iris[1] #first column
iris[[1]]
iris$Sepal.Length

iris[,1]
iris[1,1]
iris$Sepal.Length[1]

# For Loops
# when you want to do something down rows of data
#takes an index value and runs it through your function
# layout: use of i to specify index value (although you could use any value here)

for(i in 1:10){ #typical syntax
print(i)
} #stores the last value

for(i in 1:10){
  print(iris$Sepal.Length[i])
  }

for(i in 1:10){
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i])
}

#store output
results <-rep(NA,nrow(mtcars))
results

for(i in 1:nrow(mtcars)){
  results[i] <- mtcars$wt[i]*100
}

results
mtcars$wt


### Week 9.2: Map Functions
# Map Family of Functions
# map functions are useful when you want to do something across multiple columns
library(tidyverse)
#two arguments: the data & the function
map(iris, mean) #default output is a list
map_df(iris,mean)

head(mtcars)

print_mpg <- function(x, y){
  paste(x,"gets",y,"miles per gallon")
}

# map2_chr(input1,input2, function) #two inputs

map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)

#embed "anonymous" function

map2_chr(rownames(mtcars), mtcars$mpg, function(x, y){
  paste(x,"gets",y,"miles per gallon")
})
