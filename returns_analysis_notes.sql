-- Sample SQL snippet for returns analysis
SELECT 
    Category, 
    Region, 
    COUNT(Returned) AS Total_Returns,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(Returned) * 100.0 / COUNT(*), 2) AS Return_Rate
FROM orders
WHERE Returned = 'Yes'
GROUP BY Category, Region
ORDER BY Return_Rate DESC;
