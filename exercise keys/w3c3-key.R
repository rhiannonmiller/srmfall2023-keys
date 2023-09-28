# Rhiannon Miller
# 9/15/2023

# this assigns the numeric value 99 to an object called "holdsanumber"
holdsanumber <- 99

# this assigns the character value string to an object called holdsastring
holdsastring <- "string"

# I installed dplyr using the Tools > install package options in the RStudio navigator
library(dplyr)

# loading the gss-mini into my environment
load("C:/Users/rhian/My Drive/Fall 2023/soc209/data/srm-gss-mini-2023.Rdata")

# looking at the 2,372th row for mother's education
gss.mini[2372,c("maeduc")]

# you can also do it this way since mother's education is the 6th column
gss.mini[2372,6]

# print colnames
colnames(gss.mini)

# using glimpse() to look at the data
glimpse(gss.mini)



