# Rhiannon Miller
# October 25, 2023
# Week 9 - Class 1 Key

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
load("srm-gss-big-2023.Rdata")

##------------------------------------------------------##

# check variable names
colnames(gss.big)

# check variable values
tabyl(gss.big,chldidel)
tabyl(gss.big,marital)

# create analysis dataset

gss.tt <- gss.big %>% 
  select(marital,chldidel,educ,speduc) %>% 
  mutate(numkids = case_when(chldidel < 0 | chldidel == 8 ~ NA,
                    chldidel >= 1 & chldidel <= 7 ~ chldidel),
         married = case_when(marital < 0 ~ NA,
                             marital >= 1 & marital <=4 ~ "ever married",
                             marital == 5 ~ "never married"),
         educ.miss = if_else(educ < 0, NA, educ),
         speduc.miss = if_else(speduc < 0, NA, speduc))


# check new dataset

colnames(gss.tt)
tabyl(gss.tt,chldidel,numkids)
tabyl(gss.tt,marital,married)
tabyl(gss.tt,educ,educ.miss)
tabyl(gss.tt,speduc,speduc.miss)

##-------------------------------------------------------##

tt.numkids.married <- t.test(numkids ~ married, data = gss.tt)
tt.numkids.married

#' The ideal number of children for ever married respondents in the GSS is 
#' not statistically significant when compared to never married respondents.
#' The mean number of ideal children for ever married respondents is 2.59; for 
#' never married respondents it is also 2.59. This demonstrates the pervasive
#' cultural norm of the ideal number of children to have. Even marital status
#' does not influence the ideal number of children.

tt.educ <- t.test(gss.tt$educ.miss, gss.tt$speduc.miss, paired=TRUE)
tt.educ

#' There is a signficant difference at the p<.05 level between the average years 
#' of education completed by respondents and their spouses in the GSS. The estimated 
#' difference between the mean highest years of schooling is .11 with respondents
#' having slightly  higher years of schooling than their spouses. This difference is very
#' small, which suggests that the difference between respondents and spouses is not
#' practically significant. The large sample size of the GSS is likely what makes this
#' difference statistically significant and unlike to be due to chance.


