# Rhiannon Miller
# September 29, 2023
# Week 5 - Class 2 Key

# loading packages
library(dplyr)
library(janitor)
library(magrittr)

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
  mutate(pk.dnt.sfr = case_when(fepresch < 0 ~ NA,
                                fepresch > 0 & fepresch < 4 ~ 0,
                                fepresch == 4 ~ 1),
         madeg = case_when(momed < 0 ~ NA,
                           momed > -1 & momed < 12 ~ "< hs",
                           momed == 12 ~ "hs",
                           momed > 12 & momed < 16 ~ "some college",
                           momed == 16 ~ "ba+",
                           momed > 16 ~ "graduate"),
         madeg = fct(madeg, levels = c("< hs", "hs", "some college", "ba+","graduate")))


# check new variables
tabyl(gss.newvars,fepresch,pk.dnt.sfr)
tabyl(gss.newvars, momed, madeg)

# crosstab of mother's education and preschool kids suffer when mom works
tabyl(gss.newvars,madeg,pk.dnt.sfr) %>% 
  adorn_totals(c("col","row")) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting(digits = 1) 

# The percentage of respondents who strongly disagree that kids suffer 
# when their mom works is still higher as the respondent's mother's level of
# educational attainment increases, though the difference looks less pronounced
# because the missing values for the preschool variable are included. It is 
# also easier to read with the labels included for mother's education.
