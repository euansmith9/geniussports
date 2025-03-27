setwd("~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project")

# Read in data

library(tidyverse)

fulldata <- read.csv("fulldata.csv")

# Create liner regression model

model1 <- lm(ModerateMistakes ~ Total_Yellow_Cards + Total_Corners, data = fulldata)
summary(model1)

# Plot number of yellows vs mistakes

ggplot(fulldata, aes(x = ModerateMistakes, y = Total_Yellow_Cards)) +
  geom_point() +
  geom_smooth(method = "lm", se=F) +
  theme_minimal() +
  labs(x = "Number of Mistakes",
       y = "Total Number of Yellow Cards in Game")

# Plot number of corners vs mistakes

ggplot(fulldata, aes(x = ModerateMistakes, y = Total_Corners)) +
  geom_point() +
  geom_smooth(method = "lm", se=F) +
  theme_minimal() +
  labs(x = "Number of Mistakes",
       y = "Total Number of Corners in Game")

# Correlation analysis

cor.test(fulldata$Total_Yellow_Cards, fulldata$ModerateMistakes)
cor.test(fulldata$Total_Corners, fulldata$ModerateMistakes)

# Hypothesis testing

with_mistakes <- fulldata %>% filter(ModerateMistakes > 0)
without_mistakes <- fulldata %>% filter(ModerateMistakes == 0)

t.test(with_mistakes$Total_Yellow_Cards, without_mistakes$Total_Yellow_Cards)
t.test(with_mistakes$Total_Corners, without_mistakes$Total_Corners)



