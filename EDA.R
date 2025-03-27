library(tidyverse)

# Create dataframe for genius sports mistake data from slide

mistake_data <- data.frame(
  Country = rep(c("Scotland", "England"), each = 3),
  Year = rep(c(2022, 2023, 2024), times = 2),
  Games = c(896, 1248, 1240, 4393, 4843, 5274),
  Mistakes = c(25, 49, 44, 149, 144, 176),
  MistakeRate = c(2.79, 3.93, 3.55, 3.39, 2.97, 3.34)
)

# Plot Mistake rates

ggplot(mistake_data, aes(x = Year, y = MistakeRate, colour = Country, group = Country)) +
  geom_line(size = 1.2) +
  labs(title = "Moderate Mistake Rate (Corners + Yellow Cards)",
       x = "Year",
       y = "Mistake Rate (%)",
       color = "Country") +
  theme_minimal() +
  scale_colour_manual(values = c("England" = "red", "Scotland" = "blue")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_continuous(breaks = c(2022, 2023, 2024))

# Set working directory

setwd("~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project")

# Read in data

df <- read.csv("fullcomparison.csv")

# Convert to date type

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Create year column

df$Year <- format(df$Date, "%Y")

df <- df %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(Year >= 2022 & Year <= 2024)

write.csv(df, "~/Library/CloudStorage/OneDrive-UniversityofStrathclyde/Fifth Year/MS984/Genius Sports Project/ourdata.csv", row.names = FALSE)

# Number of yellow cards analysis

yellow_cards_by_year <- df %>%
  group_by(Country, Year) %>%
  summarise(avg_yellow_cards = mean(HY + AY)) %>%
  arrange(Year)

ggplot(yellow_cards_by_year) +
  geom_line(aes(x = Year, y = avg_yellow_cards, colour = Country, group = Country),linewidth = 1.2) +
  labs(title = "Average Yellow Cards per Game by Year",
       x = "Year",
       y = "Average Yellow Cards per Game") +
  scale_colour_manual(values = c("England" = "red", "Scotland" = "blue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_continuous(breaks = c(2022, 2023, 2024))

# Number of corners analysis

corners_by_year <- df %>%
  group_by(Country, Year) %>%
  summarise(avg_corners = mean(HC + AC, na.rm=TRUE)) %>%
  arrange(Year)

ggplot(corners_by_year) +
  geom_line(aes(x = Year, y = avg_corners, colour = Country, group = Country),linewidth = 1.2) +
  labs(title = "Average Corners per Game by Year",
       x = "Year",
       y = "Average Corners per Game") +
  scale_colour_manual(values = c("England" = "red", "Scotland" = "blue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_continuous(breaks = c(2022, 2023, 2024))





