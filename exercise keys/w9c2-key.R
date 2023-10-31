# Rhiannon Miller
# October 27, 2023
# Week 9 - Class 2 Key

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

gss.chisq <- gss.big %>% 
  select(educ,maeduc,paeduc) %>% 
  mutate(rdeg = case_when(educ < 0 ~ NA,
                          educ > -1 & educ < 12 ~ "< hs",
                          educ == 12 ~ "hs",
                          educ > 12 & educ < 16 ~ "some college",
                          educ >= 16 ~ "ba+"),
         rdeg = fct(rdeg, levels = c("< hs", "hs", "some college", "ba+")),
         madeg = case_when(maeduc < 0 ~ NA,
                          maeduc > -1 & maeduc < 12 ~ "< hs",
                          maeduc == 12 ~ "hs",
                          maeduc > 12 & maeduc < 16 ~ "some college",
                          maeduc >= 16 ~ "ba+"),
         madeg = fct(madeg, levels = c("< hs", "hs", "some college", "ba+")),
         padeg = case_when(paeduc < 0 ~ NA,
                           paeduc > -1 & paeduc < 12 ~ "< hs",
                           paeduc == 12 ~ "hs",
                           paeduc > 12 & paeduc < 16 ~ "some college",
                           paeduc >= 16 ~ "ba+"),
         padeg = fct(padeg, levels = c("< hs", "hs", "some college", "ba+")))


# check new dataset

colnames(gss.chisq)
tabyl(gss.chisq,educ,rdeg)
tabyl(gss.chisq,maeduc,madeg)
tabyl(gss.chisq,paeduc,padeg)


##-------------------------------------------------------##

#running chi-square tests
rpa.chisq <- chisq.test(gss.chisq$rdeg,gss.chisq$padeg)
rma.chisq <- chisq.test(gss.chisq$rdeg,gss.chisq$madeg)

rpa.chisq
rma.chisq

# looking at distributions
tabyl(gss.chisq %>% filter(!is.na(madeg) & !is.na(rdeg)),
      madeg,rdeg) %>% 
  adorn_totals(c("row","col")) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting(digits = 1)  

tabyl(gss.chisq %>% filter(!is.na(padeg) & !is.na(rdeg)),
      padeg,rdeg) %>% 
  adorn_totals(c("row","col"))%>% 
  adorn_percentages() %>% 
  adorn_pct_formatting(digits = 1)  

# Interpretation

#' Both chi-square tests are highly significant at the p<.05 level. This suggests
#' a strong association between both mother and father's degree attainment and 
#' respondents' degree attainment in the GSS. Respondents' degree attainment is
#' not independent of their parents' degree attainment. From this we can infer
#' that children's educational attainment is strongly associated with their parents'
#' degree attainment.
#' 
#' The bivariate crosstabs of each comparison suggest that both mother's and father's
#' degree attainment is similarly distributed with respondents' degree attainment.
#' Each cell of mother's attainment is close in value to those for father's attainment,
#' with most differing by only 2 percent. This suggests and equally important relationship
#' for the degree attainment of both parents.

