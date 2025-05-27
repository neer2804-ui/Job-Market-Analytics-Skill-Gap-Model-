# Analyst: Neer B
cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE)
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) 
options(scipen = 100)
# Install necessary packages (only run once)
# install.packages("dplyr")
# install.packages("readr")
# install.packages("skimr")

# Load libraries
library(dplyr)
library(readr)
library(skimr)
library(ggplot2)
library(tidyr) 
# Step 1: Load the cleaned dataset
path <- "D:/NEU project files/Data mining project/draft/enriched_postings_cleaned.csv"
jobs_data <- read_csv(path)

# Step 2: Quick View of the Data
glimpse(jobs_data)  # Like str() but nicer
summary(jobs_data)  # Summary statistics
nrow(jobs_data)
sum(duplicated(jobs_data))

# Step 3: Check Missing Values
colSums(is.na(jobs_data))
# View all column names
colnames(jobs_data)

# Step 4: Full Data Overview (nice report)
skim(jobs_data)  # Beautiful full summary: numeric, categorical, missing %, etc.
summary(jobs_data$normalized_salary)

#############eda############
ggplot(jobs_data, aes(x = formatted_experience_level)) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Job Count by Experience Level", x = "Experience Level", y = "Count")

jobs_data %>%
  count(all_industries, sort = TRUE) %>%
  top_n(10) %>%
  ggplot(aes(x = reorder(all_industries, n), y = n)) +
  geom_col(fill = "skyblue") +
  coord_flip() +
  labs(title = "Top 10 Industries by Job Count", x = "Industry", y = "Count") +
  theme_minimal()

remote_summary <- jobs_data %>%
  count(remote_allowed) %>%
  mutate(pct = round(n / sum(n) * 100, 1),
         label = paste0(remote_allowed, " (", pct, "%)"))

ggplot(remote_summary, aes(x = "", y = n, fill = factor(remote_allowed))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Remote Jobs Distribution", fill = "Remote Allowed") +
  theme_void()

# Top 10 demanded skills
top_skills <- jobs_data %>%
  separate_rows(all_skills, sep = ", ") %>%
  group_by(all_skills) %>%
  summarise(skill_count = n()) %>%
  arrange(desc(skill_count)) %>%
  slice_head(n = 10)

# Plot
ggplot(top_skills, aes(x = reorder(all_skills, skill_count), y = skill_count)) +
  geom_bar(stat = "identity", fill = "coral") +
  coord_flip() +
  labs(title = "Top 10 In-Demand Skills",
       x = "Skill", y = "Number of Job Postings") +
  theme_minimal()

#company popularity
company_popularity <- jobs_data %>%
  group_by(company_name) %>%
  summarise(total_views = sum(views, na.rm = TRUE)) %>%
  arrange(desc(total_views)) %>%
  slice_head(n = 10)

ggplot(company_popularity, aes(x = reorder(company_name, total_views), y = total_views)) +
  geom_segment(aes(xend = company_name, yend = 0), color = "grey") +
  geom_point(color = "purple", size = 5) +
  coord_flip() +
  labs(title = "Top 10 Companies by Job Views", x = "Company", y = "Total Views") +
  theme_minimal(base_size = 14)

boxplot(jobs_data$normalized_salary, main = "Outlier Check for Salary", col = "tomato")

#####################################################
# Top 10 industries by average salary
jobs_data %>%
  group_by(all_industries) %>%
  summarise(avg_salary = mean(normalized_salary, na.rm = TRUE)) %>%
  arrange(desc(avg_salary)) %>%
  slice_head(n = 10)

# Top 10 industries by % of remote jobs
jobs_data %>%
  group_by(all_industries) %>%
  summarise(remote_jobs_pct = mean(remote_allowed, na.rm = TRUE) * 100) %>%
  arrange(desc(remote_jobs_pct)) %>%
  slice_head(n = 10)

# Top 10 demanded skills
library(tidyr)  # for separate_rows
jobs_data %>%
  separate_rows(all_skills, sep = ", ") %>%
  group_by(all_skills) %>%
  summarise(skill_count = n()) %>%
  arrange(desc(skill_count)) %>%
  head(10)

