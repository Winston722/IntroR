####SETUP
#Author: D. Winston Underwood Jr
#Date: January 7th, 2019
#Last Modified: January 7th, 2019
#Purpose: Basics of R for UBWA

#lines 8-20 install necessary packages. The loop that starts on line 15 checks
#to see if the package is installed, and installs it if it isnt. Then for each
#package, it is loaded into the working environment.
neededPackages <- c("tidyverse"
                    , "rvest"
                    , "rstudioapi"
                    , "rlang"
                    #add more packages if needed here
)

for (i in neededPackages){
  if( !is.element(i, .packages(all.available = TRUE)) ) {
    install.packages(i)
  }
  library(i,character.only = TRUE)
}

#this sets the variable 'current_path' equal to whereever this file is open,
#which is inside the R Workshop folder
current_path <- getActiveDocumentContext()$path %>% dirname %>% setwd

#we also want a variable called 'wd' that we can reference for our main working
#directory
wd <- getwd()

#R can be used as a calculator for arithmatic
3 + 5
2^5
log(3, base = 8)

#R can be used for boolean math, although == is used instead of = for boolean
#evaluation
4 + 3 == 8
TRUE & TRUE
TRUE | FALSE
TRUE | FALSE & !TRUE == FALSE    #order of operations matters!

1 == TRUE
0 == FALSE

#You can assign variables with <- sign, do not use the = sign for assignment
a <- 5
b <- 2
c <- a + b

#how would you print the variable C to the console?



givenName <- "Winston"
lastName <- "Underwood"
#paste combines text strings and seperates them with a space unless you tell it
#otherwise
fullName <- paste(givenName,lastName)

#R is most powerful when working with a vector, ie an array which is created
#with the c() function
#When working with vectors, operations happen row-wise, ie when adding, the
#first rows of vectors are added, then the second rows are added, etc
firstVector <- c(1, 2, 3, 4)
secondVector <- c(1, 2, 4, 8)
#add these two vectors together and assign it to variable "thirdVector"


#how would you add 1 to each element of thirdVector?


#let's take a look at how piping works
#These next two lines do the exact same thing
grades <- as.numeric(    c(92, 81, 55, 100, 101)     )
grades <- c(92, 81, 55, 100, 101) %>% as.numeric()
#whether we put the vector inside the as.numeric command, or "pipe" them
#together, the same action is occuring. Piping is prefered because it can often
#be read easier because everything is linear: first do x, then do y.

#two different ways to take the mean
avgGrade <- mean(grades)

#how would we 'pipe' this?


#two different ways to take the median
medianGrade <- grades %>% median()
medianGrade <- median(grades)



#Data frames are the most useful and powerful structure in R and is essentially
#a vector of vectors (2D array)
courses <- as.character(c("Accounting II"
                          , "Early Roman History"
                          , "Honors Colours and Shapes"
                          , "Bayesian Modeling"
                          , "Spanish III"))

professors <- as.character(c("Mark Wahlberg"
                            , "Livy"
                            , "Steve Rogers"
                            , "Jessica Day"
                            , "Jose Gonzalez"))

#this combines our vectors by column (cbind) and creates a dataframe from that
#data, and stores it in the variable "classes" and because it is a dataframe,
#it's best practice to store it with the suffix ".df"
classes.df <- as.data.frame(cbind(grades, courses, professors)
                            , stringsAsFactors = FALSE)

#to select certain columns, we need to know the column names:
colnames(classes.df)

#this next line transforms the grades column from character type to numeric
classes.df$grades <- classes.df$grades %>% as.numeric()

#to select certain columns, we use the 'select' function and tell it what column
#or columns we want
classes.df %>% select("grades")

classes.df %>% select("grades", "professors")

#Can you figure out what this next line does?
classes.df %>% filter(grades > 95) %>% select(professors)

#How would you return the names of the classes where your grades are less than
#90?

