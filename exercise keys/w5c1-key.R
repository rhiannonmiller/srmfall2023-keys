# Rhiannon Miller
# September 27, 2023
# Week 5 - Class 1 Key

# loading packages
library(dplyr)
library(janitor)

# setting working directory
setwd("C:/Users/rhian/My Drive/Fall 2023/soc209/data")

# load data
load("srm-gss-big-2023.Rdata")

##------------------------------------------------------##

# check variable names
colnames(gss.big)

# create analysis dataset

gss.pk <- gss.big %>% 
  select(id_,year,maeduc,fepresch) %>% 
  relocate(id_,year,maeduc,fepresch) %>% 
  rename(id = id_, momed = maeduc)

# check new dataset

colnames(gss.pk)

# create new variables
gss.newvars <- gss.pk %>% 
  mutate(pk.dnt.sfr = if_else(fepresch == 4, 1,0)) %>% 
  filter(fepresch > 0) %>% 
  mutate(madeg = case_when(momed < 0 ~ NA,
                          momed > -1 & momed < 12 ~ 0,
                          momed == 12 ~ 1,
                          momed > 12 & momed < 16 ~ 2,
                          momed == 16 ~ 3,
                          momed > 16 ~ 4))

# check new variables
tabyl(gss.newvars,fepresch,pk.dnt.sfr)
tabyl(gss.newvars, momed, madeg)
