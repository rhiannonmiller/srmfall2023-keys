# Rhiannon Miller
# November 1, 2023
# Week 10 - Class 1 Key

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

# create analysis dataset

gss.reg <- gss.big %>% 
  select(educ,paeduc,marital) %>% 
  mutate(educ.miss = if_else(educ < 0,NA,educ),
         padeg = case_when(paeduc < 0 ~ NA,
                           paeduc > -1 & paeduc < 12 ~ "< hs",
                           paeduc == 12 ~ "hs",
                           paeduc > 12 & paeduc < 16 ~ "some college",
                           paeduc >= 16 ~ "ba+"),
         padeg = fct(padeg, levels = c("< hs", "hs", "some college", "ba+")),
         ev.married = case_when(marital < 0 ~ NA,
                                marital >= 1 & marital <= 4 ~ 1,
                                marital == 5 ~ 0))

#check variable

tabyl(gss.reg,educ,educ.miss)
tabyl(gss.reg,paeduc,padeg) 
tabyl(gss.reg,marital,ev.married) 


##-------------------------------------------------------##

# run analysis

m1 <- lm(educ.miss ~ padeg, data = gss.reg)
summary(m1)

# Interpretation

#' Father's degree attainment is strongly predictive of their children's higest grade
#' completed in the GSS. Each coefficient is significant at the p<.001 level.
#' Relative to respondents whose fathers did not graduate from high school, those
#' whose father's received a high school diploma are expected to have an additional 
#' 1.65 years of schooling. Respondents whose father's completed some college are expected
#' to have an additional 2.53 years of schooling, relative to respondents with fathers
#' who did not finish high school. Finally, those whose fathers have a bachelor's degree
#' or higher are expected to have an additional 3.50 years of schooling, relative to  
#' those in the reference category.
#' 
#' The R-squared is high with a value of 0.18. This means that about 18 percent of the 
#' variance in respondent's educational attainment can be explained by father's highest
#' degree completed.
#'
#' A comparison of these results to example from the class slides suggests a similar
#' relationship between mother's degree attainment and respondent's highest grade 
#' completed. The coeficients in the regression for father's degree are all very similar
#' to those for mother's degree. The R-squared values are also very close. From these
#' results we cannot determine if mother or father's highest degree completed is more 
#' influential on repsondent's highest grade completed.

# LPM for Ever Married

m2 <- lm(ev.married ~ educ.miss, data = gss.reg)
summary(m2)

# Interpretation

#' Years of education is associated with statistically significant decrease
#' in the probability of ever marrying among respondents in the GSS. This
#' is significant at the p<0.001 level. For each additional year of educational
#' attainment completed by respondents in the GSS, the probability of ever being
#' married decreases by 0.6 percent. The R-squared of this model is 0.0016, which 
#' means that highest grade completed explains only 0.1 percent of the variance in
#' Whether or not someone ever marries. 
#' 
#' Both the R-squared and the magnitude of the coefficient indicate that while the 
#' association between highest grade completed and ever marrying is statistically 
#' significant, it is not practically significant. For example, moving from 8 
#' years of educational attainment to 16 years would only change the probability 
#' of ever marrying by 4.8 percent. This is a very large difference in educational 
#' attainment that would not change the probability very meaningfully.
