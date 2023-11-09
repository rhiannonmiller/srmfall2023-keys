# Rhiannon Miller
# November 6, 2023
# Week 10 - Class 2 Key

library(magrittr)
library(janitor)
library(dplyr)
library(forcats)
library(ggplot2)
library(DescTools)

# setting working directory
setwd("C:/Users/rhian/My Drive/Fall 2023/soc209/data")

# load data
load("srm-gss-big-2023.Rdata") 

# prepare data
gss.mvr <- gss.big %>% 
  select(id_,agekdbrn,maeduc,paeduc,incom16,hispanic,racecen1) %>% 
  rename(id = id_) %>% 
  mutate(agekdbrn.miss = if_else(agekdbrn < 0,NA,agekdbrn),
         madeg = case_when(maeduc < 0 ~ NA,
                           maeduc > -1 & maeduc < 12 ~ "< hs",
                           maeduc == 12 ~ "hs",
                           maeduc > 12 & maeduc < 16 ~ "sc",
                           maeduc >= 16 ~ "ba+"),
         madeg = fct(madeg,levels = c("< hs","hs","sc","ba+")),
         padeg = case_when(paeduc < 0 ~ NA,
                           paeduc > -1 & paeduc < 12 ~ "< hs",
                           paeduc == 12 ~ "hs",
                           paeduc > 12 & paeduc < 16 ~ "sc",
                           paeduc >= 16 ~ "ba+"),
         padeg = fct(padeg,levels = c("< hs","hs","sc","ba+")),
         inc16 = case_when(
           incom16 < 0 | incom16 == 8 | incom16 == 9 ~ NA,
           incom16 == 1 ~ "avg--",
           incom16 == 2 ~ "avg-",
           incom16 == 3 ~ "avg",
           incom16 == 4 ~ "avg+",
           incom16 == 5 ~ "avg++"),
         inc16 = fct(inc16, levels = c("avg--","avg-","avg","avg+","avg++")),
         hisp = case_when(hispanic < 0 ~ NA,
                          hispanic == 1 ~ 0,
                          hispanic > 1 ~ 1),
         race = case_when(racecen1 < 0 & hispanic < 0 ~ NA,
                          racecen1 == 16 | hisp == 1 ~ "hisp",
                          racecen1 == 1 ~ "white",
                          racecen1 == 2 ~ "black",
                          racecen1 == 3 ~ "naan",
                          racecen1 >=4 & racecen1 <= 14 ~ "aapi",
                          racecen1 == 15 ~ "other"),
         race = fct(race, levels = c("white","black","hisp","aapi","naan","other")))

#check variables
tabyl(gss.mvr,agekdbrn,agekdbrn.miss)
tabyl(gss.mvr,maeduc,madeg)
tabyl(gss.mvr,paeduc,padeg)
tabyl(gss.mvr,incom16,inc16)
tabyl(gss.mvr,hispanic,hisp)
tabyl(gss.mvr,racecen1,race)

# model building
mvr1 <- lm(agekdbrn.miss ~ madeg, data = gss.mvr)
mvr2 <- lm(agekdbrn.miss ~ madeg + padeg, data = gss.mvr)
mvr3 <- lm(agekdbrn.miss ~ madeg + padeg + inc16, data = gss.mvr)
mvr4 <- lm(agekdbrn.miss ~ madeg + padeg + inc16 + race, data = gss.mvr)

# print results
summary(mvr1)
summary(mvr2)
summary(mvr3)
summary(mvr4)