# Rhiannon Miller
# September 18, 2023

# seting working directory
# this tells R where to look for my data
setwd("C:\\Users\\rhian\\My Drive\\Fall 2023\\soc209\\data")

# loading data into environment
# if I hadn't set my working directory 
# I would need to give the full file path
load("srm-gss-mini-2023.Rdata")

# Answers to Part 5
# a) The educ variable is the highest grade attended by respondents
# b) asks respondents whether they favor or oppose gun permits
# c) The negative values are missing
#    1 means the respondent favors gun permits
#    2 means the respondent opposes gun permits


# creating one variable crosstab
# in order to do this I need to load the janitor package
library(janitor)

tabyl(gss.mini.nomiss,educ) 