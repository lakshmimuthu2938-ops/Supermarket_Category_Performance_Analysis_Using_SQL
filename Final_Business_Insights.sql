SELECT Category, SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Category
ORDER BY Total_Revenue DESC
LIMIT 1;
SELECT Category, SUM(Profit) AS Total_Profit
FROM raw_sales
GROUP BY Category
ORDER BY Total_Profit DESC
LIMIT 1;
SELECT Category, SUM(Revenue) AS Total_Revenue
FROM raw_sales
GROUP BY Category
ORDER BY Total_Revenue ASC
LIMIT 1;