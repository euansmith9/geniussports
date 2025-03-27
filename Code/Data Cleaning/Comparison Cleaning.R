setwd("~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/Comparison Data")

library(tidyverse)

# English Premier League Data
Prem2021 <- read.csv("Prem2021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

Prem2022 <- read.csv("Prem2022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

Prem2023 <- read.csv("Prem2023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

Prem2024 <- read.csv("Prem2024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

# Scottish Premiership Data
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

# Championship Data
Champ2021 <- read.csv("Champ2021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

Champ2022 <- read.csv("Champ2022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

Champ2023 <- read.csv("Champ2023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

Champ2024 <- read.csv("Champ2024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

# League One Data
League12021 <- read.csv("League12021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

League12022 <- read.csv("League12022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

League12023 <- read.csv("League12023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

League12024 <- read.csv("League12024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

# League Two Data
League22021 <- read.csv("League22021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

League22022 <- read.csv("League22022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

League22023 <- read.csv("League22023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

League22024 <- read.csv("League22024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

# Scottish Championship Data
ScoChamp2021 <- read.csv("ScoChamp2021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

ScoChamp2022 <- read.csv("ScoChamp2022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

ScoChamp2023 <- read.csv("ScoChamp2023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

ScoChamp2024 <- read.csv("ScoChamp2024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

# Scottish League One Data
ScoLeague12021 <- read.csv("ScoLeague12021.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2021/22") %>%
  select(!Time)

ScoLeague12022 <- read.csv("ScoLeague12022.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2022/23") %>%
  select(!Time)

ScoLeague12023 <- read.csv("ScoLeague12023.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2023/24") %>%
  select(!Time)

ScoLeague12024 <- read.csv("ScoLeague12024.csv") %>%
  select(Div:AR) %>%
  mutate(season = "2024/25") %>%
  select(!Time)

comparison_data <- bind_rows(
  Prem2021, Prem2022, Prem2023, Prem2024,
  ScoPrem2021, ScoPrem2022, ScoPrem2023, ScoPrem2024,
  Champ2021, Champ2022, Champ2023, Champ2024,
  League12021, League12022, League12023, League12024,
  League22021, League22022, League22023, League22024,
  ScoChamp2021, ScoChamp2022, ScoChamp2023, ScoChamp2024,
  ScoLeague12021, ScoLeague12022, ScoLeague12023, ScoLeague12024
)

comparison_data <- comparison_data %>%
  mutate(Competition = case_when(
    Div == "E0" ~ "England Premier League",
    Div == "E1" ~ "England Championship",
    Div == "E2" ~ "England League 1",
    Div == "E3" ~ "England League Two",
    Div == "SC0" ~ "Scotland Premiership",
    Div == "SC1" ~ "Scotland Championship",
    Div == "SC2" ~ "Scotland League 1",
    Div == "SC3" ~ "Scotland League Two",
  )) %>%
  rename(Season = season) %>%
  mutate(Country = case_when(
    Div == "E0" ~ "England",
    Div == "E1" ~ "England",
    Div == "E2" ~ "England",
    Div == "E3" ~ "England",
    Div == "SC0" ~ "Scotland",
    Div == "SC1" ~ "Scotland",
    Div == "SC2" ~ "Scotland",
    Div == "SC3" ~ "Scotland",
  ))


write.csv(comparison_data, "~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/fullcomparison.csv", row.names = FALSE)


