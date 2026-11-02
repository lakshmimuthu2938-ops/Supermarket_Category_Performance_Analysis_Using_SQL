SELECT
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    SUM(Revenue) AS Total_Revenue,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT Transaction_ID), 2
    ) AS Average_Transaction_Value
FROM raw_sales;

SELECT
    Product_Name,
    Profit,
    CASE
        WHEN Profit >= 1000 THEN 'High Profit'
        WHEN Profit >= 500 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS Profit_Category
FROM raw_sales
ORDER BY Profit DESC;

SELECT
    Product_Name,
    Category,
    Profit
FROM raw_sales
WHERE Profit > (
    SELECT AVG(Profit)
    FROM raw_sales
)
ORDER BY Profit DESC;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Category
HAVING SUM(Revenue) > (
    SELECT AVG(Category_Revenue)
    FROM (
        SELECT SUM(Revenue) AS Category_Revenue
        FROM raw_sales
        GROUP BY Category
    ) AS Category_Summary
)
ORDER BY Total_Revenue DESC;

SHOW TABLES;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY Category
HAVING SUM(Revenue) < 40000
ORDER BY Total_Revenue ASC;

SELECT
    Category,
    SUM(Profit) AS Total_Profit,
    DENSE_RANK() OVER (
        ORDER BY SUM(Profit) DESC
    ) AS Profit_Rank
FROM raw_sales
GROUP BY Category
ORDER BY Profit_Rank;

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Transaction_Date, '%Y-%m') AS Sales_Month,
        SUM(Revenue) AS Total_Revenue
    FROM raw_sales
    GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
)
SELECT
    Sales_Month,
    Total_Revenue,
    LEAD(Total_Revenue) OVER (
        ORDER BY Sales_Month
    ) AS Next_Month_Revenue
FROM Monthly_Sales
ORDER BY Sales_Month;

SELECT
    Store_Name,
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity_Sold) AS Total_Quantity
FROM raw_sales
GROUP BY Store_Name, Category
ORDER BY Store_Name, Total_Revenue DESC;

SELECT
    Region,
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity_Sold) AS Total_Quantity
FROM raw_sales
GROUP BY Region, Category
ORDER BY Region, Total_Revenue DESC;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    ROUND(
        SUM(Profit) / SUM(Revenue) * 100, 2
    ) AS Profit_Margin_Percentage,
    SUM(Quantity_Sold) AS Total_Quantity
FROM raw_sales
GROUP BY Category
ORDER BY Total_Revenue DESC;