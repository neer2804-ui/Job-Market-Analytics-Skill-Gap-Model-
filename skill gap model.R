# Analyst: Neer B
cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE)
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) 
options(scipen = 100)
# Libraries
# ===============================
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

# ===============================
# Dataset
# ===============================
path <- "D:/NEU project files/Data mining project/draft/enriched_postings_cleaned.csv"
jobs_data <- read_csv(path)

# ===============================
# Step 1: Define User Input
# ===============================
desired_title <- "DATA"  # Replace with any job title
user_skills <- c( "Sales", "Business Devlopment","Advertising")  # Replace with actual user skills

# ===============================
#Step 2: Filter Jobs Matching Title
# ===============================
title_filtered <- jobs_data %>%
  filter(grepl(desired_title, title, ignore.case = TRUE)) %>%
  filter(!is.na(all_skills))  # Remove rows with missing skills

# ===============================
# Step 3: Extract and Count Skills
# ===============================
skill_counts <- title_filtered %>%
  separate_rows(all_skills, sep = ", ") %>%
  mutate(all_skills = trimws(all_skills)) %>%  # Clean whitespace
  group_by(all_skills) %>%
  summarise(freq = n(), .groups = "drop") %>%
  arrange(desc(freq))

# ===============================
# Step 4: Identify Skill Gaps
# ===============================
skill_counts <- skill_counts %>%
  mutate(
    user_has_skill = all_skills %in% user_skills,
    gap = ifelse(user_has_skill, "✓", "✗")  # Mark missing skillsx
  )

# ===============================
# Step 5: Recommend Top Missing Skills
# ===============================
top_missing_skills <- skill_counts %>%
  filter(gap == "✗") %>%
  slice_max(order_by = freq, n = 10)

# ===============================
# Step 6: Visualize Missing Skills
# ===============================
ggplot(top_missing_skills, aes(x = reorder(all_skills, freq), y = freq, fill = freq)) +
  geom_col() +
  coord_flip() +
  labs(
    title = paste("Top Missing Skills for:", desired_title),
    subtitle = "Compared to your current skills",
    x = "Missing Skill",
    y = "Frequency in Job Postings"
  ) +
  scale_fill_gradient(low = "lightblue", high = "steelblue") +
  theme_minimal()

# ===============================
# Optional: View Skill Gap Table
# ===============================
print(top_missing_skills)
