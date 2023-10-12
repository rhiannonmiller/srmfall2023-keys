# Rhiannon Miller
# October 3, 2023
# Week 6 - Class 3 Key

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
  relocate(id,year,hrs1,fepres) %>% 
  mutate(hrs.wk = case_when(hrs1 < 0 ~ NA,
                            hrs1 >= 0 ~ hrs1))

# check new dataset

colnames(gss.mct)
tabyl(gss.mct,hrs1,hrs.wk)

##-------------------------------------------------------##

mean.hrswk <- mean(gss.mct$hrs.wk, na.rm = TRUE)
sd.hrswk <- sd(gss.mct$hrs.wk, na.rm = TRUE)

pct.hrswk.20 <- pnorm(20, mean = mean.hrswk, sd = sd.hrswk)
pct.hrswk.60 <- pnorm(60, mean = mean.hrswk, sd = sd.hrswk)

#' People who work 20 hours per week are in the 7th percentile (or 6.8) of the 
#' distribution. People who work 60 hours per week are in the 90th percentile.
#' These results suggest that a large majority of workers work between 20 and 
#' 60 hours per week. There isn't a large percentage of the working population
#' that works more than that. This may be because it is hard to find work that 
#' allows you to work fewer than 20 hours per week. It may also be that it's hard
#' to make a living while working fewer hours than that. People likely don't work more
#' than 60 hours per week because of both labor laws and because it is hard to
#' eat, sleep, and take care of family while working more than 60 hours per week.




