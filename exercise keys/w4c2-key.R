# Rhiannon Miller
# September 23, 2023
# Week 4 - Class 2 key

# load packages into environment
library(janitor)
library(dplyr)

# I'm checking to see what my current working directory is
getwd()

# now I'm explicitly setting my working directory
# your working directory is where R looks for things you want to read into your
# R environment like data
# Note: working directories are always in quotes
setwd("C:\\Users\\rhian\\My Drive\\Fall 2023\\soc209\\data\\")

# Your script should have a file path that looks like this:
# "/Users/yourname/Documents/srmfall2023/data"

# load data into R
# this is how I get the data from a random folder on my computer into my R evironment
# you can see that it's loaded in the upper left quadrant
# Note: file names are always in quotes
load("srm-gss-big-2023.Rdata")

# assign the dataset to a new object
gss.big2 <- gss.big

# colnames() function shows you the column or variable names of a data set
colnames(gss.big2)

# print the colnames and assign them to a new object
gss.big.vars <- colnames(gss.big2)

# Checking your data #####

# to check the number of observations and variables use the glimpse function
# this function also prints the first rows of the data set
glimpse(gss.big2)

# this data set has 72,390 rows and 67 columns

# to print the first few rows of a data set, you can also use indexing
gss.big2[1:10,]
gss.big2[1:10,gss.big.vars]

# to show a cross tab, use the tabyl() function
# note: for the tabyl() function to work, you need to have the package
# it comes from loaded
# see line 6 above

tabyl(gss.big,year)

# 2006 has more has 4510 observations, more than any other year

# two variable crosstab
# don't remember how to do this? Look at slide 25 in w3c3
tabyl(gss.big,year,maeduc) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting(digits = 1) 

# 1972: 8th grade and 12th grade
# 2021: 12th grade and 16th grade (bachelor's degree)

# in both years, the grade levels with the highest proportion of observations is 12, 14, and 16
# Note: this corresponds to high school diploma (12), associate degree (14), and bachelor's degree (16)

# Just for Fun #####

# Indexing values
gss.big[25673, c("educ")]
# the highest grade attended by the 1,357th participant is 9

# other syntax you could use
gss.big[25673,28]

# in what survey years are the 9876 - 9901 respondents
gss.big[9876:9901,66]

# another way to do the same thing
gss.big[9876:9901,c("year")]

# they are in the 1978 survey
