# 📊 SQL Project: Customer Behavior Analysis for Personal Loan Marketing

This file explains the SQL logic used to analyze customer behavior at Universal Bank to identify personal loan adoption patterns and product usage trends.

---

## 🗂️ Dataset Overview

- **Table:** `Customers`
- **Fields:** ID, Age, Income, Family, Education, Mortgage, PersonalLoan, CreditCard, CDAccount, Online, etc.

---
## 🛠️ SQL Tasks Completed

### 1. Data Preparation
- Structured and loaded customer data into a SQL table

### 2. Descriptive Analysis
- Total customers
- Total loans taken
- Loan acceptance rate
- Average credit card spending (CCAvg)

### 3. Segmented Analysis
- Loan acceptance by: age, income, education, family, ZIP, mortgage
- Product usage counts and rates
- Cross-sell potential (2+ products and/or loan)
- Campaign targeting (high income + CCAvg)

### 4. Demographic Insights
- Distribution by education level and ZIP code
- Mortgage ownership trends and impact on product usage and loan decisions

### 5. Views Created 
- `ProductUsageMetrics`: Product usage (counts & rates)
- `MortgageSegments`: Customer profiles by mortgage and product behavior

