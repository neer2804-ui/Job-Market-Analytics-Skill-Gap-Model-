# Job-Market-Analytics-Skill-Gap-Model-
Job Market Analytics Project A data mining and visualization project analyzing over 15,000 LinkedIn job postings to uncover trends in salary, remote work, skill demand, and market gaps. Built using R and Power BI, this project is aimed at providing actionable insights for job seekers, recruiters, and policy makers.

**Objectives**

- Identify industries offering the highest remote flexibility and pay
- Visualize top skills in demand by frequency and sector
- Cluster job roles based on salary and skill complexity
- Use regression to model job post engagement (views, applies)
- Create a custom Skill Gap Model to guide upskilling paths

**Tools & Technologies**
- R: dplyr, ggplot2, tidyr, readr, leaps
- Power BI: Interactive dashboard visualizations
- Techniques: K-Means Clustering, Chi-Square Test, Best Subset Regression, Skill Gap Modeling

**Key Features**
- 📦 Exploratory Data Analysis: Outlier detection, top industries, company visibility
- 💼 Skill Demand Mapping: Tokenized skills across 15,000+ job descriptions
- 🔀 K-Means Clustering: Grouped job roles by salary & skill count using log-transformed normalization
- 📊 Chi-Square Test: Analyzed relationship between experience level and remote flexibility
- 📈 Regression Modeling: Best subset selection revealed views as the strongest predictor of job post engagement
- 🧩 Skill Gap Model: Custom-built R model to recommend top missing skills based on a user-defined profile

**Some Insights**
- Remote jobs were more frequent for mid-senior roles.
- Outlier salaries > $500M revealed data quality risks in scraped job data.
- Top skills in demand: Information Technology, Sales, Management, Business Development
- Best salary clusters aligned with moderate skill/moderate pay roles.
- Most predictive feature for application volume was job views, not salary or skill count.

**Real-World Value**
- For job seekers: Align skills and expectations to actual demand
- For educators: Identify areas for curriculum updates
- For hiring teams: Recognize engagement drivers and design effective job descriptions
- For data analysts: Explore how simple models outperform when data is noisy

**About the model**
- Best Model:
The best-performing model included only one predictor: applies. 
This model had the highest Adjusted R² ≈ 0.1098

**What Does Adjusted R² of 0.1098 Mean?**
- Adjusted R² measures how well the model explains variance in the target variable (job views), accounting for the number of predictors. An Adjusted R² of ~0.11 means that approximately 11% of the variance in job views is explained by the number of applications alone.

**Note**
This model isn’t a classification model, so traditional accuracy doesn’t apply here. Instead, Adjusted R² and visual diagnostics (residual plots, RMSE, etc.) are used for evaluation








































  


