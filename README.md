# regression-and-ml-business
1. Load Libraries & Dataset

Uses readxl, dplyr, ggplot2, caret, corrplot, rpart, and randomForest to import and process
business_rf_dataset.xlsx.

2. Exploratory Data Analysis (EDA)

Summary statistics

Boxplot of monthly revenue by sales channel

Correlation matrix for numeric variables:

session_duration_min

monthly_visits

discount_level

review_score

monthly_revenue_usd

3. Data Preparation

Convert sales_channel into a factor

Split data into train (80%) and test (20%) using createDataPartition

4. Machine Learning Models

Three predictive models are trained:

Multiple Linear Regression

Examines linear relationships between features and monthly revenue.

Decision Tree (rpart)

Creates interpretable splits to predict revenue.

 Random Forest (100 trees)

Ensemble model with feature importance visualization.

5. Model Evaluation

Each model’s predictions are evaluated using RMSE and R² via postResample.

 Files

business_rf_dataset.xlsx – Dataset with customer & revenue metrics

revenue_modeling.R – Main script (this file)

 Purpose

This project demonstrates a full end-to-end predictive modeling pipeline in R for business analytics, useful for forecasting, marketing optimization, and customer insights.
