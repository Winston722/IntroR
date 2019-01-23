####SETUP
#Author: D. Winston Underwood Jr
#Date: January 3rd, 2019
#Last Modified: January 23rd, 2019
#Purpose: Web scraping example for UBWA

#First we need to install the packages we plan on using. Installing only needs
#to be done once, so if you are using packages that has already been installed,
#there is no need to install it again.

#The require function returns true if the package is installed and loads it, and
#returns false if the package is not installed. The if statements below check if
#a package is installed--if it is, it loads the package. If it isn't, it
#installs it and loads it.

#The library function does the same thing as require, except it doesn't return a
#true or false--instead if either loads the package if it is installed, or
#throws an error if it isn't.

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

#now that we have all the packages installed and loaded, we need to set our
#working directory, which is a way to tell R where to find the files we
#reference. Our working directory is going to be the "R Workshop" folder you
#downloaded. This next block of code uses the rstudioapi library, and will not
#work if that package was not installed and loaded.

#this sets the variable 'current_path' equal to whereever this file is open,
#which is inside the R Workshop folder
#dirname returns the folder location of that file path we just created
#setwd sets our working directory to that folder path
current_path <- getActiveDocumentContext()$path %>% dirname() %>% setwd()

#we also want a variable called 'wd' that we can reference for our main working
#directory
wd <- getwd()

#import the myMovies file from your working directory. Feel free to create your
#own list of movies and import that instead / as well, just make sure if you are
#saving the file to the correct folder with the correct extention (csv)

myMovies.df <- read.csv('Movies.csv')
myMovies.df

#how would you rename the column name?




url <- 'https://www.imdb.com/search/title?groups=top_250&sort=user_rating&count=250'
con <- url(url,"rb")
webpage <- read_html(con)

#for title and metacritic score, we'll use piping

titles <- webpage %>%                           #Start with the webpage
  html_nodes(".lister-item-header a") %>%       #grab these html nodes
  html_text() %>%                               #translate the nodes to text
  as.data.frame()                               #store it as a data frame

#metacritic rating
score <- html_nodes(webpage,".favorable") %>%
  html_text() %>%
  as.numeric() %>%
  as.data.frame()

#for IMBD rating and description we won't use piping

#imdb rating
rating_html <- html_nodes(webpage,".ratings-imdb-rating")
rating_text <- html_text(rating_html)
rating_number <- as.numeric(rating_text)
rating <- as.data.frame(rating_number)

#we can even pull out director and stars, however we would need regular
#expressions (regex) to extract those items from the text source
stars_html <- html_nodes(webpage,".text-muted+ p")
stars <- html_text(stars_html, trim = TRUE)
stars <- gsub("\n","",stars) %>% as.data.frame()
View(stars)
#now we need to pull everything together and create a single data frame of data
#with the different columns we have.
#cbind is the function to bind columns together. rbind is the function to bind
#rows together
topMovies.df <- cbind(titles, rating)
colnames(topMovies.df) <- c("titles", "rating")

#now we have two data frames: topMovies.df has the IMDB top 250 movies, and
#myMovies.df which has the movies I've seen this year. Our goal is to identify
#which of them have been seen this year. That requires a join. To do a join, it
#is helpful if the column names are the same.

#Because our two data frames have one column with the same name, we don't need
#to specify what columns we want to join by--the inner_join function will auto-
#matically look for columns with similar names. If you don't have columns with
#the same name, you'll have to define what the two columns are that are to be
#connected.

watchedMovies.df <- inner_join(topMovies.df, myMovies.df)

#how many movies have you watched? 


#how many movies have you watched in the top 250?


#What is the percentage of movies you've watched in the top 250?
