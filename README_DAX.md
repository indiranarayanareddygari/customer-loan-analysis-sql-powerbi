# 📐 DAX Measures & Calculated Columns for Power BI Dashboard

This file contains all custom DAX logic used in the Power BI dashboard:  
**Customer Behavior Analysis for Personal Loan Marketing**

---

## 📄 Calculated Columns

### 🔹 Age Grouping

```dax
AgeGroup = 
SWITCH(
    TRUE(),
    'universalbank customers'[Age] < 30, "Under 30",
    'universalbank customers'[Age] >= 30 && 'universalbank customers'[Age] <= 50, "30-50",
    'universalbank customers'[Age] > 50, "Over 50",
    "Unknown"
)
````

---

### 🔹 Education Level Mapping

```dax
EducationLevel = 
SWITCH(
    'universalbank customers'[Education],
    1, "Undergrad",
    2, "Graduate",
    3, "Advanced/Professional",
    "Unknown"
)
```

---

### 🔹 Mortgage Ownership Label

```dax
MortgageStatus = 
IF(
    'universalbank customers'[Mortgage] > 0,
    "Has Mortgage",
    "No Mortgage"
)
```

---

### 🔹 Income Bracket

```dax
IncomeBracket = 
SWITCH(
    TRUE(),
    'universalbank customers'[Income] < 50, "Low Income",
    'universalbank customers'[Income] <= 100, "Middle Income",
    'universalbank customers'[Income] > 100, "High Income",
    "Unknown"
)
```

---

## 🧮 Measures

### 🔹 Total Loans Taken

```dax
TotalLoansTaken = 
SUM('universalbank customers'[PersonalLoan])
```

---

### 🔹 Loan Acceptance Rate (Overall)

```dax
Loan_acceptance_rate = 
DIVIDE(
    SUM('universalbank customers'[PersonalLoan]),
    COUNT('universalbank customers'[ID])
) * 100
```

---

### 🔹 Loan Acceptance Rate (Context Aware)

```dax
LoanAcceptanceRateByAgeGroup = 
DIVIDE(
    SUM('universalbank customers'[PersonalLoan]),
    COUNT('universalbank customers'[ID])
) * 100
```

> Used with `AgeGroup`, `EducationLevel`, etc. in visuals for segmented rates.

---

### 🔹 Cross-Sell Customers (2+ Products)

```dax
CrossSellCustomers = 
CALCULATE(
    COUNTROWS('universalbank customers'),
    FILTER(
        'universalbank customers',
        'universalbank customers'[CreditCard] +
        'universalbank customers'[CDAccount] +
        'universalbank customers'[Online] >= 2
    )
)
```

---

✅ These measures support dynamic visuals in the dashboard, including KPI cards, influencers, decomposition trees, and product usage analysis.
