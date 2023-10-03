# Rhiannon Miller
# October 3, 2023
# Week 6 - Class 1 Key

# loading packages
library(dplyr)
library(janitor)
library(magrittr)
library(tidyverse)
library(ggplot2)
library(DescTools)

# setting working directory
setwd("C:/Users/rhian/My Drive/Fall 2023/soc209/data")

# load data
load("srm-gss-medium-2023.Rdata")

##------------------------------------------------------##

# check variable names
colnames(gss.medium)

# create analysis dataset

gss.mct <- gss.medium %>% 
  select(id,year,hrs1,fepres) %>% 
  relocate(id,year,hrs1,fepres) 

# check new dataset

colnames(gss.mct)

# create new variables
gss.mct <- gss.mct %>% 
  mutate(hrs.wk = case_when(hrs1 < 0 ~ NA,
                            hrs1 >= 0 ~ hrs1),
         vote4wmn = case_when(fepres < 0 ~ NA,
                              fepres == 1 ~ "yes",
                              fepres == 2 ~ "no"),
         vote4wmn = fct(vote4wmn, levels = c("yes","no")))

# Note: in the codebook fepres has a possible value of 5, but no observations
#       are present in this dataset with that value, so they are not included
#       in the recode and the fct() would throw an error of they were incldued.

# check created variables

tabyl(gss.graph,hrs1,hrs.wk)
tabyl(gss.graph,fepres,vote4wmn)

##-------------------------------------------------------##

mean.hrswk <- mean(gss.mct$hrs.wk, na.rm = TRUE)
median.hrswk <- median(gss.mct$hrs.wk, na.rm = TRUE)
mode.hrswk <- Mode(gss.mct$hrs.wk, na.rm = TRUE)

mean.hrswk # 41.3519
median.hrswk # 40
mode.hrswk # 40

# We know from the previous exercise that the distribution of this
# variable is symmetric, so it makes sense that the three MCTs would be
# close to each other.

##-----##

# cannon calculate mean, categorical variable

# can't calculate median because variable isn't ordered

mode.vote4wmn <- Mode(gss.mct$vote4wmn, na.rm = TRUE)

mode.vote4wmn # Mode is "yes"

# The distribution is fairly uneven because the large majority of values are "yes,"
# so it makes sense that the mode is the only mct that is applicaple and it is
# also a good represenation of the distribution/data.


