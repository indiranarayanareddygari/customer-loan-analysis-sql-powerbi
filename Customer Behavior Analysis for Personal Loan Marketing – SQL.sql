CREATE DATABASE IF NOT EXISTS UniversalBank;
USE UniversalBank;
show databases;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    ID INT PRIMARY KEY,
    Age INT,
    Experience INT,
    Income INT,
    ZIPCode INT,
    Family INT,
    CCAvg DECIMAL(10,2),
    Education INT,
    Mortgage INT,
    PersonalLoan TINYINT,
    SecuritiesAccount TINYINT,
    CDAccount TINYINT,
    `online` TINYINT,
    CreditCard TINYINT
);
-- UNIVERSAL BANK SQL ANALYSIS & KPI PROJECT
-- Author: [Your Name]
-- Description: Categorized SQL queries for portfolio project (Marketing, Financial Behavior, Demographics)

-- 🎯 MARKETING & LOAN CAMPAIGNS

-- 1. Total number of customers
SELECT COUNT(*) AS Total_Customers FROM Customers;

-- 2. Personal Loan Acceptance Rate
select 
count(*) as total_customers,
sum(personalloan) as Loans_taken,
-- Out of all customers, what percentage accepted the personal loan offer?” — rounded to 2 decimal places.
round(sum(personalloan)*100.00/count(*),2) as Loan_acceptance_rate
from customers;

-- 3. Loan Acceptance by Education Level
select 
count(*) as total_customers,
sum(personalloan) as Loans_taken,
round(sum(personalloan)*100.00/count(*),2) as Loan_acceptance_rate
from customers
group by education;

-- 4. Loan Acceptance by Income Bracket
select 
case when income < 50 then 'less income'
when income between 50 and 100 then 'middle income'
else 'high income'
end as income_bracket,
Count(*) as total_customers,
sum(personalloan) as Loans_taken,
round(sum(personalloan)*100.00/count(*),2) as Loan_acceptance_rate
from customers
group by income_bracket;

-- 5. Loan Acceptance Rate by Age Group
SELECT 
  CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 50 THEN '30-50'
    ELSE 'Over 50'
  END AS AgeGroup,
  COUNT(*) AS Total_Customers,
  SUM(PersonalLoan) AS Loans_Taken,
  ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS Loan_acceptance_rate
FROM Customers
GROUP BY AgeGroup;

-- 6. Conversion Rate by Family Size
SELECT Family, 
       COUNT(*) AS Total_Customers, 
       SUM(PersonalLoan) AS Loans_Taken,
       ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS Loan_acceptance_rate
FROM Customers
GROUP BY Family;


-- 7. Loan Acceptance Rate by ZIP Code
SELECT ZIPCode,
       COUNT(*) AS Total_Customers,
       SUM(PersonalLoan) AS Loans_Taken,
       ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS Loan_acceptance_rate
FROM Customers
GROUP BY ZIPCode
ORDER BY Loan_acceptance_rate DESC;

-- 8. Loan Acceptance by Education and Family Size
SELECT Education, Family,
       COUNT(*) AS Total_Customers,
       SUM(PersonalLoan) AS Loans_Taken,
       ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS ConversionRate
FROM Customers
GROUP BY Education, Family;

-- 9. Loan Acceptance Rate by Mortgage Status and Income Bracket
SELECT 
  CASE WHEN Mortgage > 0 THEN 'Has Mortgage' ELSE 'No Mortgage' END AS MortgageStatus,
  CASE 
    WHEN Income < 50 THEN 'Low Income'
    WHEN Income BETWEEN 50 AND 100 THEN 'Middle Income'
    ELSE 'High Income'
  END AS IncomeBracket,
  COUNT(*) AS Total_Customers,
  SUM(PersonalLoan) AS Loans_Taken,
  ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS AcceptanceRate
FROM Customers
GROUP BY MortgageStatus, IncomeBracket;

-- 10. High Potential Campaign Targets
SELECT 
  ID, Age, Income, CCAvg, Education, PersonalLoan,
  CASE 
    WHEN Income > 100 AND CCAvg > 3 THEN 'High Potential'
    ELSE 'Low Potential'
  END AS TargetGroup
FROM Customers;


-------------------------------------- 💳 FINANCIAL BEHAVIOR----------------------------------------

-- 11. Average Credit Card Spend (CCAvg) by Income Bracket
SELECT 
  CASE 
    WHEN Income < 50 THEN 'Low Income '
    WHEN Income BETWEEN 50 AND 100 THEN 'Middle Income'
    ELSE 'High Income'
  END AS IncomeBracket,
  ROUND(AVG(CCAvg), 2) AS AvgCreditCardSpend
FROM Customers
GROUP BY IncomeBracket;

-- 12. Average Credit Card Spend (CCAvg) by Age Group
SELECT 
  CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 50 THEN '30-50'
    ELSE 'Over 50'
  END AS AgeGroup,
  ROUND(AVG(CCAvg), 2) AS AvgCreditCardSpend
FROM Customers
GROUP BY AgeGroup;

-- 13. Average Credit Card Spend (CCAvg) by Education Level
SELECT Education, 
       ROUND(AVG(CCAvg), 2) AS Avg_CreditCard_Spend
FROM Customers
GROUP BY Education;

-- 14. Avg Credit Card Spend by Education and Family Size
SELECT Education, Family,
       ROUND(AVG(CCAvg), 2) AS AvgCreditCardSpend
FROM Customers
GROUP BY Education, Family;

-- 15. Product Usage Counts (CD, Online, CreditCard)
SELECT 
  SUM(CASE WHEN CreditCard = 1 THEN 1 ELSE 0 END) AS CreditCardUsers,
  SUM(CASE WHEN CDAccount = 1 THEN 1 ELSE 0 END) AS CDAccountUsers,
  SUM(CASE WHEN `Online` = 1 THEN 1 ELSE 0 END) AS OnlineBankingUsers
FROM Customers;

-- 16. Product Usage Rates (%)
SELECT 
  ROUND(SUM(CDAccount) * 100.0 / COUNT(*), 2) AS CDAccountRate,
  ROUND(SUM(`Online`) * 100.0 / COUNT(*), 2) AS OnlineBankingRate,
  ROUND(SUM(CreditCard) * 100.0 / COUNT(*), 2) AS CreditCardRate
FROM Customers;



---------------------------- created view for above 2 query to get transposed output---------
  
CREATE VIEW ProductUsageMetrics AS
SELECT 'CreditCardUsers' AS Metric, SUM(CASE WHEN CreditCard = 1 THEN 1 ELSE 0 END) AS Value FROM Customers
UNION ALL
SELECT 'CDAccountUsers', SUM(CASE WHEN CDAccount = 1 THEN 1 ELSE 0 END) FROM Customers
UNION ALL
SELECT `Online`, SUM(CASE WHEN `Online` = 1 THEN 1 ELSE 0 END) FROM Customers
UNION ALL
SELECT 'CreditCardRate', ROUND(SUM(CreditCard) * 100.0 / COUNT(*), 2) FROM Customers
UNION ALL
SELECT 'CDAccountRate', ROUND(SUM(CDAccount) * 100.0 / COUNT(*), 2) FROM Customers
UNION ALL
SELECT `Online`, ROUND(SUM(`Online`) * 100.0 / COUNT(*), 2) FROM Customers;

SELECT * FROM ProductUsageMetrics;


-- 17. Cross-Selling (2+ Products: CreditCard, CDAccount, Online)
SELECT 
  COUNT(*) AS CrossSellCustomers
FROM Customers
WHERE 
  (CreditCard + CDAccount + `Online`) >= 2;

-- 18. Cross-Selling (2+ Products incl. Loan)
SELECT 
  COUNT(*) AS CrossSellingCustomers
FROM Customers
WHERE 
  (PersonalLoan + CDAccount + CreditCard) >= 2;



-- 📍 DEMOGRAPHICS & SEGMENTS

-- 19. Mortgage Ownership and Loan Acceptance
SELECT 
  CASE 
    WHEN Mortgage > 0 THEN 'Has Mortgage'
    ELSE 'No Mortgage'
  END AS MortgageStatus,
  COUNT(*) AS Total_Customers,
  SUM(PersonalLoan) AS Loans_Taken,
  ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS AcceptanceRate
FROM Customers
GROUP BY MortgageStatus;

-------------------------------- 20. Mortgage Ownership Rate
SELECT 
  CASE WHEN Mortgage > 0 THEN 'Has Mortgage' ELSE 'No Mortgage' END AS MortgageStatus,
  COUNT(*) AS Total_Customers,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Customers), 2) AS Percentage
FROM Customers
GROUP BY MortgageStatus;

-- 21. Customer Distribution by Education Level
SELECT Education, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY Education;

-- 22. Account Penetration by ZIP Code
SELECT ZIPCode, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY ZIPCode
ORDER BY CustomerCount DESC;

-- 23. Mortgage vs. Loan Acceptance Analysis(👉 Shows if customers with mortgages are more likely to take personal loans.)
SELECT 
  CASE WHEN Mortgage > 0 THEN 'Has Mortgage' ELSE 'No Mortgage' END AS MortgageStatus,
  SUM(PersonalLoan) AS LoansTaken,
  COUNT(*) AS TotalCustomers,
  ROUND(SUM(PersonalLoan) * 100.0 / COUNT(*), 2) AS LoanAcceptanceRate
FROM Customers
GROUP BY MortgageStatus;

-- 24. Average Income by Mortgage Ownership(👉 Helps show whether people with mortgages have higher income or spend more on credit cards.)
SELECT 
  CASE WHEN Mortgage > 0 THEN 'Has Mortgage' ELSE 'No Mortgage' END AS MortgageStatus,
  ROUND(AVG(Income), 2) AS AvgIncome,
  ROUND(AVG(CCAvg), 2) AS AvgCCUsage
FROM Customers
GROUP BY MortgageStatus;

--  25. Mortgage Ownership by Education Level(👉 Shows how education correlates with mortgage ownership.)
SELECT 
  Education,
  COUNT(*) AS TotalCustomers,
  SUM(CASE WHEN Mortgage > 0 THEN 1 ELSE 0 END) AS WithMortgage,
  ROUND(SUM(CASE WHEN Mortgage > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS MortgageOwnershipRate
FROM Customers
GROUP BY Education;

-- 26 Top ZIP Codes with Highest Mortgage Penetration(👉 ZIP code segmentation with a filter to avoid skew from small groups.)
SELECT 
  ZIPCode,
  COUNT(*) AS TotalCustomers,
  SUM(CASE WHEN Mortgage > 0 THEN 1 ELSE 0 END) AS MortgageOwners,
  ROUND(SUM(CASE WHEN Mortgage > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS MortgageRate
FROM Customers
GROUP BY ZIPCode
HAVING COUNT(*) > 10
ORDER BY MortgageRate DESC
LIMIT 10;

-- 27.Mortgage + Product Usage Combo (Cross-Sell Targeting)-👉 Helps understand cross-sell opportunities among mortgage holders.
SELECT 
  CASE WHEN Mortgage > 0 THEN 'Has Mortgage' ELSE 'No Mortgage' END AS MortgageStatus,
  SUM(CreditCard) AS CreditCardUsers,
  SUM(CDAccount) AS CDAccountUsers,
  SUM(`Online`) AS OnlineBankingUsers,
  ROUND(SUM(CreditCard) * 100.0 / COUNT(*), 2) AS CreditCardPenetration
FROM Customers
GROUP BY MortgageStatus;

--- 28 Create a View for Mortgage Segments
CREATE VIEW MortgageSegments AS
SELECT 
  ID,
  CASE WHEN Mortgage > 0 THEN 'Has Mortgage' ELSE 'No Mortgage' END AS MortgageStatus,
  Income,
  Education,
  ZIPCode,
  CreditCard,
  CDAccount,
  'Online',
  PersonalLoan
FROM Customers;

SELECT MortgageStatus, AVG(Income), SUM(PersonalLoan)
FROM MortgageSegments
GROUP BY MortgageStatus;
