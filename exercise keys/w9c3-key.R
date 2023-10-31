# Rhiannon Miller
# October 30, 2023
# Week 9 - Class 3 Key

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

gss.par <- gss.big %>% 
  select(paeduc,educ) %>% 
  mutate(paeduc.miss = if_else(paeduc < 0,NA,paeduc),
         educ.miss = if_else(educ < 0,NA,educ))

#check variable

tabyl(gss.par,paeduc,paeduc.miss) 
tabyl(gss.par,educ,educ.miss) 


##-------------------------------------------------------##

# run analysis

par.cor <- cor(gss.par$paeduc.miss, gss.par$educ.miss, use = "complete.obs")
par.cor

m1 <- lm(educ.miss ~ paeduc.miss, data = gss.par)
summary(m1)

# Interpretation

#' There is a positive correlation of 0.49 between father's and respondent's 
#' highest grade completed in the GSS. This suggests a strong correlation
#' between father's and respondent's educational attainment.
#' 
#' The regression analysis shows that father's education is strongly predictive 
#' of respondent's highest grade completed in the GSS. Each additional year of 
#' education corresponds to 0.35 years of additional schooling for respondents.
#' The R-squared for this model is 0.24, which is very high and tells us that 24
#' percent of the variance in respondent's highest grade completed is explained by
#' their father's highest grade completed.
#' 
#' When we compare these results to the in-class example, we see that they are very
#' similar to mother's highest grade completed. Mother's highest grade completed
#' had a 0.47 positive correlation with respondent's highest grade completed, a
#' coefficient of 0.38 years in the bivariate regression analysis, and a R-squared 
#' of 0.21.
#' 
#' One may conclude that mother's educational attainment has a stronger association 
#' with respondent's education than their fathers because the coefficient in the 
#' regression analysis is larger. However, the R-squared for father's regression
#' analysis is higher, suggesting that father's education can account for more of the
#' variation in the model. Practically, the estimates for the correlation and regression
#' analyses are very close in magnitude, suggesting that both father's and mother's
#' highest grade completed are important for respondent's educational attainment.
