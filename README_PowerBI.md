# 📈 Power BI Dashboard: Customer Behavior Analysis

This Power BI dashboard visualizes customer behavior using insights derived from the Universal Bank dataset. It focuses on personal loan acceptance and product usage patterns, built using SQL + DAX.

---

## 🧱 Dashboard Sections

### 🔹 1. KPI Cards
- **Total Customers**
- **Loans Taken**
- **Loan Acceptance Rate (%)**
- **Cross-Sell Customers (2+ Products)**

---

### 🔹 2. Customer Segment Analysis
- **Loan Acceptance by:**
  - Age Group
  - Income Bracket
  - Education Level
  - Family Size
- **Mortgage Status vs. Loan Acceptance**

---

### 🔹 3. Product Usage Breakdown
- Product Adoption (Credit Card, CD Account, Online Banking)
- Usage by:
  - Education Level
  - Mortgage Status

---

### 🔹 4. Advanced Visuals
- **Key Influencers:** What factors drive loan acceptance?
- **Decomposition Tree:** Drilldown of loans by Age, Education, ZIP, and Mortgage

---

### 🔹 5. Slicers for Interactivity
- Age Group
- Education Level
- Mortgage Status
- Top 10 ZIP Codes

---

## 📐 Key DAX Logic

See [`README_DAX.md`](./README_DAX.md) for full DAX formulas.

Includes:
- `Loan_acceptance_rate`
- `CrossSellCustomers`
- `LoanAcceptanceRateByAgeGroup`
- `AgeGroup`, `IncomeBracket`, `EducationLevel`, `MortgageStatus` (calculated columns)

---

## 📊 Power BI File

- `CustomerBehaviorAnalysis.pbix`

Open in Power BI Desktop to explore or extend the report.



