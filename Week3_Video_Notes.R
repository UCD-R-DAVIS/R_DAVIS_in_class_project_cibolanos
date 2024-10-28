### Week 3 Video Notes

# Vector Math ---
x <- 1:10
x
x + 3 #can do c() to have it be a single number in the vector
x * 10

y <- 100:109
y
x + y #because the vectors are the same length, its creating a pair between the index value one in the first vector, and the index value of 100 in the second vector 
cbind(x,y, x + y)

z <- 1:2
z
x + z
cbind(x,z,x+z) #R is recycling the numbers 1 and 2 until it has populated all 10 index values of x
z <- 1:3
cbind(x,z,x+z) #longer object length is not a multiple of shorter object length, so itll keep recycling through

a <- x+z

x[c(TRUE,FALSE)] # selection is now every other number in the original vector
x[c(TRUE,FALSE,FALSE)] 

# Missing Values ---

NA #special character
NaN #not the same thing, but recognized as not a number
"NA" # do not use quotes for NA values

heights <- c(2,4,4,NA,6)
mean(heights)
max(heights)
sum(heights)
mean(heights, na.rm = TRUE) #na.rm will basically tell R to remove NA values if its set to true

is.na(heights) # gives us the logical values for if there is a NA or not in the vector
!is.na(heights) #tells R to basically invert to select the opposite

#to remove the NA values from a vector, pull up your vector (in this case heights), use the is.na function with the vector in parentheses
heights[!is.na(heights)]

#complete cases will return an object that only has values where there is the full information available
heights[complete.cases(heights)]


### Other Data Types

# Lists - a data type that is constructed of multiple vectors; it can have different data types, data lengths; essentially it's multiple vectors in one object

c(4,6,"dog") #spits out the values all in one row under the same line

list(4,6,"dog") #gives us three separate vectors

a<- list (4,6,"dog")
class(a)
str(a)

b <- list(4,letters, "dog")
str(b)
length(b)
length(b[[2]]) #index value for letters

# Data frames #you can have different data variables but they all have to be the same length
letters
data.frame(letters)
df <- data.frame(letters)
length(df)
dim(df) #first number is number of rows and then the second number is the number of columns
nrow(df) #number of rows
ncol(df) #number of columns
df2 <- data.frame(letters, letters) 
str(df2)
dim(df2)

data.frame(letters,"dog") 
data.frame(letters,1) 
data.frame(letters,1:2) #R has decided to recycle one and two until it reaches the 26 for letters; in data frames the lengths have to be the same
data.frame(letters, 1:3) #error

#Matrices are basically a data frame but it has to be the same exact type of data in the X and the Y
matrix(nrow = 10, ncol=10)
matrix(1:10,nrow=10, ncol=10)
matrix(1:10,nrow=10, ncol=10, byrow=TRUE)
m <- matrix(1:10,nrow=10, ncol=10, byrow=TRUE) #row is on the left side of the comma, and column is the right side of the comma
m [1,3]
m[c(1,2),c(5,6)]

#Arrays are basically matrices but in three dimensions; essentially stacked matrices

#Factors essentially characters but with some sort of level value or order to them
response <- factor(c("no","yes","maybe","no","maybe","no"))
class(response)
levels(response)
nlevels(response)
typeof(response)
response 

response <- factor(response, levels = c("yes","maybe","no"))
response

#Converting a factor
# if we want to convert to as.character instead of factor
as.character(response)

year_fct <- factor(c(1990,1983,1977,1998,1999))
year_fct
as.numeric(year_fct)
as.numeric(as.character(year_fct))

#Renaming the different levels
levels(response)
levels(response)[1] <- "YES"
response

levels(response) <- c("YES", "MAYBE", "NO")
response
