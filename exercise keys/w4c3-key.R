# Rhiannon Miller
# September 25, 2023
# Week 4 - Class 3 Key

# loading packages
library(dplyr)
library(tidyverse)
library(janitor)

# setting working directory
setwd("C:/Users/rhian/My Drive/Fall 2023/soc209/data")

# load data
load("srm-gss-medium-2023.Rdata")

##------------------------------------------------------##

# printing columns
colnames(gss.medium)

gss.med.vars <- colnames(gss.medium)

# assign ds to a new object
gss.med <- gss.medium %>% 
  # select variables 
  select(id,year,fehome,fework,fechld,fepresch,fefam,kidsuffr) %>% 
  # rename variables
  # note the new name comes before the old name
  rename(home.nt.cntry = fehome,
         shld.wmn.wk = fework,
         mthr.wk.dnt.hrt.cld = fechld,
         pk.sfr.mom.wk = fepresch,
         mnwk.wmnhm = fefam,
         pk.sfr.mom.wk2 = kidsuffr) %>% 
  # reorder variables - note that you have to use new varible names
  relocate(id,year) %>% 
  # this selection statement asks R to keep all obs that are
  # less than 1980 OR greater than or equal to 2020
  filter(year < 2020 & year >= 2010) 

# check new dataset
# (I didn't ask you to do this explicitly, but you always should
# check your work to make sure R did everything you expected)

glimpse(gss.med)

tabyl(gss.med,year)