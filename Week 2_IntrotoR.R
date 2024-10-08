#arithmetic
3 + 4

#incomplete operation
2 * 5

#order of operations  
4 + (8*3) ^ 2

#this is a comment

#scientific notation
2/100000
4e3

#mathematical functions
exp(1)

exp(3)

log(4)

sqrt(4)

#r help files
?log
log(2,4)
log(4,2)

x <-1
x
rm(x)


#nested functions
sqrt(exp(4))
log(exp(100))

#six comparison functions
mynumber <- 6
mynumber == 5 #two equals signs makes sure you're not reassigning the variable
mynumber !=5
mynumber>4
mynumber<3
mynumber>=2
mynumber<=-1

#objects and assignments
mynumber <- 7

othernumber <- -3

mynumber * othernumber

#object name conventions
numSamples <- 50
num_samples <- 40 
rm(num_samples)

#errors and warnings
log_of_word <- log("a_word")
log_of_word

log_of_negative <- log(-2)
log_of_negative

#challenge
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb = elephant1_kg *2.2

elephant2_lb > elephant1_lb

myelephants <- c(elephant1_lb, elephant2_lb)

which(myelephants == max(myelephants))
