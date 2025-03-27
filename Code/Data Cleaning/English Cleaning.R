setwd("~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/English Football Data")

library(tidyverse)

prem2010 <- read.csv("Prem2010.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2010/11")

prem2011 <- read.csv("Prem2011.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2011/12")

prem2012 <- read.csv("Prem2012.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2012/13")

prem2013 <- read.csv("Prem2013.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2013/14")

prem2014 <- read.csv("Prem2014.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2014/15") %>%
  drop_na()

prem2015 <- read.csv("Prem2015.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2015/16")

prem2016 <- read.csv("Prem2016.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2016/17")

prem2017 <- read.csv("Prem2017.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2017/18")

prem2018 <- read.csv("Prem2018.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2018/19")

prem2019 <- read.csv("Prem2019.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2019/20") %>%
  select(!Time)

prem2020 <- read.csv("Prem2020.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2020/21") %>%
  select(!Time)

prem2021 <- read.csv("Prem2021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

prem2022 <- read.csv("Prem2022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

prem2023 <- read.csv("Prem2021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

prem2024 <- read.csv("Prem2024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

prem_combined <- bind_rows(
  prem2010, prem2011, prem2012, prem2013,
  prem2014, prem2015, prem2016, prem2017,
  prem2018, prem2019, prem2020, prem2021,
  prem2022, prem2023, prem2024
  )

prem_combined <- prem_combined %>%
  rename(Season = season)

write.csv(prem_combined, "~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/English Football Data/fullprem.csv", row.names = FALSE)



