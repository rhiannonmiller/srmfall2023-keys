# Rhiannon Miller
# September 29, 2023
# Week 5 - Class 3 Key

# loading packages
library(dplyr)
library(janitor)
library(magrittr)
library(tidyverse)
library(ggplot2)

# setting working directory
setwd("C:/Users/rhian/My Drive/Fall 2023/soc209/data")

# load data
load("srm-gss-medium-2023.Rdata")

##------------------------------------------------------##

# check variable names
colnames(gss.medium)

# create analysis dataset

gss.graph <- gss.medium %>% 
  select(id,year,hrs1,fepres) %>% 
  relocate(id,year,hrs1,fepres) 

# check new dataset

colnames(gss.graph)

# create new variables
gss.graph <- gss.graph %>% 
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

# create hrs.wk graph
# variable is continuous, so use a histogram

ggplot(gss.graph %>% remove_missing(na.rm = TRUE), 
       aes(hrs.wk)) +
  geom_histogram(bins = 15, color = "#342c5c", fill = "#342c5c")

# The distribution is roughly symmetric with a prominent mode at 40 hours.

# create vote4wmn graph
# variable is discrete, so use a bar graph

ggplot(gss.graph %>% remove_missing(na.rm = TRUE), 
       aes(vote4wmn)) +
  geom_bar(color = "#342c5c", fill = "#342c5c")

# even though this distribution may look like it is skewed, it only has two values
# so we might just say that it is unimodal.
