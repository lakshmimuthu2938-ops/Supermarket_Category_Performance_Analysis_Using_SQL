CREATE DATABASE SupermarketAnalysis;
USE SupermarketAnalysis;
SELECT DATABASE();

USE SupermarketAnalysis;

CREATE TABLE raw_sales (
    Transaction_ID VARCHAR(20),
    Transaction_Date DATE,
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(100),
    Category VARCHAR(100),
    Store_ID VARCHAR(20),
    Store_Name VARCHAR(100),
    Region VARCHAR(50),
    Quantity_Sold INT,
    Unit_Price DECIMAL(10,2),
    Cost_Price DECIMAL(10,2),
    Revenue DECIMAL(12,2),
    Profit DECIMAL(12,2)
);

USE SupermarketAnalysis;
TRUNCATE TABLE raw_sales;

USE SupermarketAnalysis;
SELECT COUNT(*) AS Total_Records
FROM raw_sales;

SELECT *
FROM raw_sales
LIMIT 10;

SELECT
    Transaction_ID,
    COUNT(*) AS Duplicate_Count
FROM raw_sales
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

SELECT *
FROM raw_sales
WHERE Transaction_ID IS NULL
   OR Transaction_Date IS NULL
   OR Product_ID IS NULL
   OR Product_Name IS NULL
   OR Category IS NULL
   OR Store_ID IS NULL
   OR Store_Name IS NULL
   OR Region IS NULL
   OR Quantity_Sold IS NULL
   OR Unit_Price IS NULL
   OR Cost_Price IS NULL
   OR Revenue IS NULL
   OR Profit IS NULL;
   
   SELECT *
FROM raw_sales
WHERE Quantity_Sold <= 0
   OR Unit_Price <= 0
   OR Cost_Price < 0
   OR Revenue < 0
   OR Profit < 0;
   
SELECT *
FROM raw_sales
WHERE Transaction_Date IS NULL;

SELECT DISTINCT Category
FROM raw_sales
ORDER BY Category;

SELECT
    SUM(Revenue) AS Total_Revenue
FROM raw_sales;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Category
ORDER BY Total_Revenue DESC;

SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY Category
ORDER BY Total_Profit DESC;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    ROUND(
        (SUM(Profit) / SUM(Revenue)) * 100, 2
    ) AS Profit_Margin_Percentage
FROM raw_sales
GROUP BY Category
ORDER BY Profit_Margin_Percentage DESC;

SELECT
    EXTRACT(YEAR FROM Transaction_Date) AS Year,
    EXTRACT(MONTH FROM Transaction_Date) AS Month,
    SUM(Revenue) AS Monthly_Revenue
FROM raw_sales
GROUP BY
    EXTRACT(YEAR FROM Transaction_Date),
    EXTRACT(MONTH FROM Transaction_Date)
ORDER BY Year, Month;

SELECT
    Product_ID,
    Product_Name,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Product_ID, Product_Name
ORDER BY Total_Revenue DESC
LIMIT 5;

SELECT
    Category,
    SUM(Revenue) AS Category_Revenue,
    ROUND(
        SUM(Revenue) * 100.0 /
        SUM(SUM(Revenue)) OVER(), 2
    ) AS Revenue_Contribution_Percentage
FROM raw_sales
GROUP BY Category
ORDER BY Revenue_Contribution_Percentage DESC;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Revenue) DESC
    ) AS Category_Rank
FROM raw_sales
GROUP BY Category;

SELECT
    Store_ID,
    Store_Name,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Store_ID, Store_Name
ORDER BY Total_Revenue DESC;

SELECT
    Region,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY Region
ORDER BY Total_Revenue DESC;

SELECT
    YEAR(Date) AS Sales_Year,
    DATEPART(QUARTER, Date) AS Sales_Quarter,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY
    YEAR(Date),
    DATEPART(QUARTER, Date)
ORDER BY
    Sales_Year,
    Sales_Quarter;
    
    DESCRIBE raw_sales;
    
    SELECT
    YEAR(Transaction_Date) AS Sales_Year,
    QUARTER(Transaction_Date) AS Sales_Quarter,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY
    YEAR(Transaction_Date),
    QUARTER(Transaction_Date)
ORDER BY
    Sales_Year,
    Sales_Quarter;
    
    CREATE DATABASE SupermarketAnalysis;
USE SupermarketAnalysis;
SELECT DATABASE();

USE SupermarketAnalysis;

CREATE TABLE raw_sales (
    Transaction_ID VARCHAR(20),
    Transaction_Date DATE,
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(100),
    Category VARCHAR(100),
    Store_ID VARCHAR(20),
    Store_Name VARCHAR(100),
    Region VARCHAR(50),
    Quantity_Sold INT,
    Unit_Price DECIMAL(10,2),
    Cost_Price DECIMAL(10,2),
    Revenue DECIMAL(12,2),
    Profit DECIMAL(12,2)
);

USE SupermarketAnalysis;
TRUNCATE TABLE raw_sales;

USE SupermarketAnalysis;
SELECT COUNT(*) AS Total_Records
FROM raw_sales;

SELECT *
FROM raw_sales
LIMIT 10;

SELECT
    Transaction_ID,
    COUNT(*) AS Duplicate_Count
FROM raw_sales
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

SELECT *
FROM raw_sales
WHERE Transaction_ID IS NULL
   OR Transaction_Date IS NULL
   OR Product_ID IS NULL
   OR Product_Name IS NULL
   OR Category IS NULL
   OR Store_ID IS NULL
   OR Store_Name IS NULL
   OR Region IS NULL
   OR Quantity_Sold IS NULL
   OR Unit_Price IS NULL
   OR Cost_Price IS NULL
   OR Revenue IS NULL
   OR Profit IS NULL;
   
   SELECT *
FROM raw_sales
WHERE Quantity_Sold <= 0
   OR Unit_Price <= 0
   OR Cost_Price < 0
   OR Revenue < 0
   OR Profit < 0;
   
SELECT *
FROM raw_sales
WHERE Transaction_Date IS NULL;

SELECT DISTINCT Category
FROM raw_sales
ORDER BY Category;

SELECT
    SUM(Revenue) AS Total_Revenue
FROM raw_sales;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Category
ORDER BY Total_Revenue DESC;

SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY Category
ORDER BY Total_Profit DESC;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    ROUND(
        (SUM(Profit) / SUM(Revenue)) * 100, 2
    ) AS Profit_Margin_Percentage
FROM raw_sales
GROUP BY Category
ORDER BY Profit_Margin_Percentage DESC;

SELECT
    EXTRACT(YEAR FROM Transaction_Date) AS Year,
    EXTRACT(MONTH FROM Transaction_Date) AS Month,
    SUM(Revenue) AS Monthly_Revenue
FROM raw_sales
GROUP BY
    EXTRACT(YEAR FROM Transaction_Date),
    EXTRACT(MONTH FROM Transaction_Date)
ORDER BY Year, Month;

SELECT
    Product_ID,
    Product_Name,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Product_ID, Product_Name
ORDER BY Total_Revenue DESC
LIMIT 5;

SELECT
    Category,
    SUM(Revenue) AS Category_Revenue,
    ROUND(
        SUM(Revenue) * 100.0 /
        SUM(SUM(Revenue)) OVER(), 2
    ) AS Revenue_Contribution_Percentage
FROM raw_sales
GROUP BY Category
ORDER BY Revenue_Contribution_Percentage DESC;

SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Revenue) DESC
    ) AS Category_Rank
FROM raw_sales
GROUP BY Category;

SELECT
    Store_ID,
    Store_Name,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Store_ID, Store_Name
ORDER BY Total_Revenue DESC;

SELECT
    Region,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY Region
ORDER BY Total_Revenue DESC;

SELECT
    YEAR(Date) AS Sales_Year,
    DATEPART(QUARTER, Date) AS Sales_Quarter,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY
    YEAR(Date),
    DATEPART(QUARTER, Date)
ORDER BY
    Sales_Year,
    Sales_Quarter;
    
    DESCRIBE raw_sales;
    
    SELECT
    YEAR(Transaction_Date) AS Sales_Year,
    QUARTER(Transaction_Date) AS Sales_Quarter,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY
    YEAR(Transaction_Date),
    QUARTER(Transaction_Date)
ORDER BY
    Sales_Year,
    Sales_Quarter;
    
WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Transaction_Date, '%Y-%m') AS Sales_Month,
        SUM(Revenue) AS Total_Revenue
    FROM raw_sales
    GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
),
Monthly_Growth AS (
    SELECT
        Sales_Month,
        Total_Revenue,
        LAG(Total_Revenue) OVER (
            ORDER BY Sales_Month
        ) AS Previous_Month_Revenue
    FROM Monthly_Sales
)
SELECT
    Sales_Month,
    Total_Revenue,
    Previous_Month_Revenue,
    ROUND(
        (Total_Revenue - Previous_Month_Revenue)
        / NULLIF(Previous_Month_Revenue, 0) * 100,
        2
    ) AS Growth_Percentage
FROM Monthly_Growth
ORDER BY Sales_Month;

WITH Yearly_Sales AS (
    SELECT
        YEAR(Transaction_Date) AS Sales_Year,
        SUM(Revenue) AS Total_Revenue
    FROM raw_sales
    GROUP BY YEAR(Transaction_Date)
),
Yearly_Growth AS (
    SELECT
        Sales_Year,
        Total_Revenue,
        LAG(Total_Revenue) OVER (
            ORDER BY Sales_Year
        ) AS Previous_Year_Revenue
    FROM Yearly_Sales
)
SELECT
    Sales_Year,
    Total_Revenue,
    Previous_Year_Revenue,
    ROUND(
        (Total_Revenue - Previous_Year_Revenue)
        / NULLIF(Previous_Year_Revenue, 0) * 100,
        2
    ) AS Growth_Percentage
FROM Yearly_Growth
ORDER BY Sales_Year;

SELECT
    Category,
    SUM(Quantity_Sold) AS Total_Sales_Volume,
    SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Category
ORDER BY Total_Sales_Volume DESC;
