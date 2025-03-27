setwd("~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/Scottish Football Data")

library(tidyverse)

# Loading and processing Scottish Premiership data
ScoPrem2010 <- read.csv("ScoPrem2010.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2010/11")

ScoPrem2011 <- read.csv("ScoPrem2011.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2011/12")

ScoPrem2012 <- read.csv("ScoPrem2012.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2012/13")

ScoPrem2013 <- read.csv("ScoPrem2013.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2013/14")

ScoPrem2014 <- read.csv("ScoPrem2014.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2014/15")

ScoPrem2015 <- read.csv("ScoPrem2015.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2015/16")

ScoPrem2016 <- read.csv("ScoPrem2016.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2016/17")

ScoPrem2017 <- read.csv("ScoPrem2017.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2017/18")

ScoPrem2018 <- read_csv("ScoPrem2018.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2018/19")

ScoPrem2019 <- read.csv("ScoPrem2019.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2019/20") %>%
  select(!Time)

ScoPrem2020 <- read.csv("ScoPrem2020.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2020/21") %>%
  select(!Time)

ScoPrem2021 <- read.csv("ScoPrem2021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

ScoPrem2022 <- read.csv("ScoPrem2022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

ScoPrem2023 <- read.csv("ScoPrem2023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

ScoPrem2024 <- read.csv("ScoPrem2024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

# Combine all Scottish Premiership data frames
ScoPrem_combined <- bind_rows(
  ScoPrem2010, ScoPrem2011, ScoPrem2012, ScoPrem2013,
  ScoPrem2014, ScoPrem2015, ScoPrem2016, ScoPrem2017,
  ScoPrem2018, ScoPrem2019, ScoPrem2020, ScoPrem2021,
  ScoPrem2022, ScoPrem2023, ScoPrem2024
)

# Rename the season column to Season (capital S for consistency)
ScoPrem_combined <- ScoPrem_combined %>%
  rename(Season = season)

# Export to CSV
write.csv(ScoPrem_combined, "~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/Scottish Football Data/fullscoprem.csv", row.names = FALSE)
