-- Superstore Returns Analysis SQL Notes
-- Author: James Wesson
-- Purpose: To simulate the SQL-based insights used in the Tableau Story dashboard

-- 1. Return Rate by Region and Product Category
SELECT 
    Region,
    Category,
    COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) AS Returned_Count,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS Return_Rate_Percent
FROM superstore_orders
GROUP BY Region, Category
ORDER BY Return_Rate_Percent DESC;

-- 2. Correlation Between Profit and Return Rate by Sub-Category
SELECT 
    SubCategory,
    SUM(Profit) AS Total_Profit,
    COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) * 1.0 / COUNT(*) AS Return_Rate
FROM superstore_orders
GROUP BY SubCategory
ORDER BY Return_Rate DESC;

-- 3. High Return Customers (Frequent Returners)
SELECT 
    Customer_ID,
    Customer_Name,
    COUNT(*) AS Total_Returns
FROM superstore_orders
WHERE Returned = 'Yes'
GROUP BY Customer_ID, Customer_Name
HAVING COUNT(*) > 3
ORDER BY Total_Returns DESC;

-- 4. Monthly Trend of Returns (To identify seasonality)
SELECT 
    DATE_TRUNC('month', Order_Date) AS Month,
    COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) AS Returns,
    COUNT(*) AS Total_Orders
FROM superstore_orders
GROUP BY Month
ORDER BY Month;
