# Rhiannon Miller
# September 18, 2023
# Week 4 - Class 1 Key

# loading packages
library(dplyr)
library(tidyverse)
library(janitor)

# setting working directory
setwd("C:/Users/rhian/My Drive/Fall 2023/soc209/data")

# load data
load("srm-gss-big-2023.Rdata")

##------------------------------------------------------##

# printing columns
colnames(gss.big)

# assign ds to a new object
gss.new <- gss.big %>% 
  # select variables 
  select(id_,year, marital,wrkstat,degree) %>% 
  #rename variables
  # note the new name comes before the old name
  rename(id = id_, rdeg = degree, marstat = marital) %>% 
  # reorder variables - note that you have to use new varible names
  relocate(id,year,marstat,rdeg,wrkstat) %>% 
  # this selection statement asks R to keep all obs that are
  # less than 1980 OR greater than or equal to 2020
  filter(year < 1980 | year >= 2020) 

# check new dataset
# (I didn't ask you to do this explicitly, but you always should
# check your work to make sure R did everything you expected)

glimpse(gss.new)

tabyl(gss.new,year)