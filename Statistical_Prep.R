setwd("~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project")

# Read in genius sports data

library(readxl)
library(tidyverse)
library(lubridate)

gs_data <- read_excel("GS Eng.Sco. Moderate mistakes 22-24.xlsx", sheet = "Export")

# Create GameID for genius sports data

gs_data <- gs_data %>%
  mutate(
    DateFormatted = format(as.Date(StartDate), "%Y%m%d"),
    HomeTeam = str_trim(str_split_fixed(Event, " v ", 2)[,1]),
    AwayTeam = str_trim(str_split_fixed(Event, " v ", 2)[,2]),
    HomeAbbr = str_to_upper(str_sub(HomeTeam, 1, 3)),
    AwayAbbr = str_to_upper(str_sub(AwayTeam, 1, 3)),
    GameID = paste0(DateFormatted, HomeAbbr, AwayAbbr),
    Competition = str_remove(Competition, "^[^ ]+ ")
  ) %>%
  filter(Competition %in% c(
    "England Premier League",
    "England Championship",
    "England League 1",
    "England League Two",
    "Scotland Premiership",
    "Scotland Championship",
    "Scotland League 1",
    "Scotland League Two"
  ))

# Create columns for mistakes

gs_data_summary <- gs_data %>%
  group_by(GameID, HomeTeam, AwayTeam, Event, Competition, DateFormatted) %>%
  summarise(ModerateMistakes = n(),
            Corner_Mistakes = sum(MistakeType == "Corner"),
            Yellow_Mistakes = sum(MistakeType == "Yellow Card")) %>%
  ungroup()

# Read in our data

ourdata <- read.csv("ourdata.csv")

# Convert to date

ourdata$Date <- as.Date(ourdata$Date, format = "%Y-%m-%d")

# Create GameID

ourdata <- ourdata %>%
  mutate(
    DateFormatted = format(Date, "%Y%m%d"),
    HomeAbbr = str_to_upper(str_sub(HomeTeam, 1, 3)),
    AwayAbbr = str_to_upper(str_sub(AwayTeam, 1, 3)),
    GameID = paste0(DateFormatted, HomeAbbr, AwayAbbr)
  )

# Combine dfs

fulldata <- ourdata %>%
  left_join(gs_data_summary, by = "GameID") %>%
  select(GameID, Date, Competition = Competition.x,  HomeTeam = HomeTeam.x, AwayTeam = AwayTeam.x, FTHG, FTAG, FTR, HS, AS, HST, AST, HF, AF, HC, AC, HY, AY, HR, AR, 
         ModerateMistakes, Corner_Mistakes, Yellow_Mistakes) %>%
  mutate(ModerateMistakes = replace_na(ModerateMistakes, 0),
         Corner_Mistakes = replace_na(Corner_Mistakes, 0),
         Yellow_Mistakes = replace_na(Yellow_Mistakes, 0))

sum(fulldata$ModerateMistakes)

sum(gs_data_summary$ModerateMistakes)

# Which GameIDs in gs_data_summary were not joined into fulldata
unmatched_gs <- gs_data_summary %>%
  filter(!GameID %in% fulldata$GameID)

team_mapping <- tibble::tibble(
  gs_data_team = c("AFC Bournemouth", "Greenock Morton", "Queens Park Rangers"),
  fulldata_team = c("Bournemouth", "Morton", "QPR")
)

# Clean names in gs_data_summary
gs_data_summary <- gs_data_summary %>%
  left_join(team_mapping, by = c("HomeTeam" = "gs_data_team")) %>%
  mutate(HomeTeam = coalesce(fulldata_team, HomeTeam)) %>%
  select(-fulldata_team)

gs_data_summary <- gs_data_summary %>%
  left_join(team_mapping, by = c("AwayTeam" = "gs_data_team")) %>%
  mutate(AwayTeam = coalesce(fulldata_team, AwayTeam)) %>%
  select(-fulldata_team)

# Fix gameID

gs_data_summary <- gs_data_summary %>%
  mutate(
    HomeAbbr = str_to_upper(str_sub(HomeTeam, 1, 3)),
    AwayAbbr = str_to_upper(str_sub(AwayTeam, 1, 3)),
    GameID = paste0(DateFormatted, HomeAbbr, AwayAbbr)
  )

# Combine dfs

fulldata <- ourdata %>%
  left_join(gs_data_summary, by = "GameID") %>%
  select(GameID, Date, Competition = Competition.x, HomeTeam = HomeTeam.x, AwayTeam = AwayTeam.x, FTHG, FTAG, FTR, HS, AS, HST, AST, HF, AF, HC, AC, HY, AY, HR, AR, 
         ModerateMistakes, Corner_Mistakes, Yellow_Mistakes) %>%
  mutate(ModerateMistakes = replace_na(ModerateMistakes, 0),
         Corner_Mistakes = replace_na(Corner_Mistakes, 0),
         Yellow_Mistakes = replace_na(Yellow_Mistakes, 0))

# Verify all gameids have been mapped correctly

sum(fulldata$ModerateMistakes)

sum(gs_data_summary$ModerateMistakes)

unmatched_gs <- gs_data_summary %>%
  filter(!GameID %in% fulldata$GameID)

sum(unmatched_gs$ModerateMistakes)

# Discrepancy in sum of mistakes (3 games unmatched are fine they are playoff games) must be a duplicate

fulldata %>%
  count(GameID) %>%
  filter(n > 1)

# Newcastle vs Brighton and Newport vs Bristol have same game id

fulldata <- fulldata %>%
  mutate(GameID = ifelse(GameID == "20220305NEWBRI" & HomeTeam == "Newcastle", "20220305NEWCBRI", GameID), 
         ModerateMistakes = ifelse(GameID == "20220305NEWCBRI", 0, ModerateMistakes),
         Corner_Mistakes = ifelse(GameID == "20220305NEWCBRI", 0, Corner_Mistakes),
         Yellow_Mistakes = ifelse(GameID == "20220305NEWCBRI", 0, Yellow_Mistakes))

# Verify

sum(fulldata$ModerateMistakes)

sum(gs_data_summary$ModerateMistakes)

sum(unmatched_gs$ModerateMistakes)

# Feature Engineering

colnames(fulldata)

fulldata <- fulldata %>%
  mutate(Total_Goals = FTHG + FTAG, 
         Total_Shots = HS + AS, 
         Total_Shots_On_Target = HST + AST,
         Total_Fouls = HF + AF,
         Total_Corners = HC + AC,
         Total_Yellow_Cards = HY + AY,
         Total_Red_Cards = HR + AR)

write.csv(fulldata, "~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/fulldata.csv", row.names = FALSE)

summary(fulldata)







