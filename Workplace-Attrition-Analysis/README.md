# Workforce Retention & Attrition Analysis

## 📌 Project Overview

Employee turnover can have a significant impact on workforce stability, productivity, and organizational costs. This project analyzes workforce data to identify patterns associated with employee attrition and understand which employee groups experience higher observed turnover.

The project uses **SQL in Google BigQuery** for data auditing, cleaning, deduplication, and analysis, followed by **Microsoft Power BI** for interactive data visualization and dashboard development.

The final dashboard provides an executive view of workforce size, employee departures, attrition rates, workforce characteristics, tenure patterns, and other factors associated with employee turnover.

---

## 🎯 Business Objective

The objective of this analysis is to help HR and management:

- Understand the overall level of employee attrition
- Identify industries with higher observed attrition rates
- Examine employee departures across job levels
- Analyze attrition patterns across employee tenure
- Explore relationships between income, tenure, and attrition
- Identify workforce factors that may warrant further retention analysis
- Support data-driven workforce retention decisions

---

## 🗂️ Dataset

The dataset contains **74,610 records** and **24 variables** covering employee demographics, employment characteristics, compensation, job information, and attrition status.

### Key variables include:

- Employee ID
- Age
- Gender
- Industry
- Job Role
- Job Level
- Monthly Income
- Years at Company
- Overtime
- Job Satisfaction
- Work-Life Balance
- Remote Work
- Education Level
- Company Tenure
- Attrition

### Data Quality

Initial data auditing identified:

- **74,610** total records
- **74,498** unique employees
- **112 duplicate records**
- No missing Employee IDs
- No missing Age values
- No missing Gender values
- No missing Job Role values
- No missing Monthly Income values
- No missing Attrition values

The 112 duplicate records were identified and removed during the cleaning stage, resulting in a final analytical dataset of **74,498 unique employees**.

---

## 🧹 Data Preparation & SQL

Data preparation was performed in **Google BigQuery**.

The workflow included:

1. Auditing the dataset for missing values
2. Checking employee ID uniqueness
3. Identifying duplicate records
4. Removing exact duplicate records
5. Creating a cleaned analytical table
6. Creating SQL views for analysis

### Final SQL structure

```text
Workforce_Analysis
        ↓
Workforce_Analysis_Cleaned
        ↓
 ┌───────────────────────────────┐
 │ workforce_overview            │
 │ attrition_by_role             │
 │ attrition_by_factors          │
 │ attrition_by_tenure           │
 └───────────────────────────────┘