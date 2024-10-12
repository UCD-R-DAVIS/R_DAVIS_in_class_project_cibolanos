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
