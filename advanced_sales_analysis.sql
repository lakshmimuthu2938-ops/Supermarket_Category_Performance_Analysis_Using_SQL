CREATE DATABASE IF NOT EXISTS SupermarketAnalysis;
USE SupermarketAnalysis;

CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE IF NOT EXISTS stores (
    store_id VARCHAR(20) PRIMARY KEY,
    store_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS sales_transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    transaction_date DATE,
    product_id VARCHAR(20),
    store_id VARCHAR(20),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    revenue DECIMAL(12,2),
    profit DECIMAL(12,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

INSERT IGNORE INTO categories (category_name)
SELECT DISTINCT Category FROM raw_sales WHERE Category IS NOT NULL;


INSERT IGNORE INTO products (product_id, product_name, category_id)
SELECT DISTINCT r.Product_ID, r.Product_Name, c.category_id
FROM raw_sales r
JOIN categories c ON r.Category = c.category_name;

INSERT IGNORE INTO stores (store_id, store_name, region)
SELECT DISTINCT Store_ID, Store_Name, Region FROM raw_sales WHERE Store_ID IS NOT NULL;

INSERT IGNORE INTO sales_transactions (transaction_id, transaction_date, product_id, store_id, quantity_sold, unit_price, cost_price, revenue, profit)
SELECT Transaction_ID, Transaction_Date, Product_ID, Store_ID, Quantity_Sold, Unit_Price, Cost_Price, Revenue, Profit 
FROM raw_sales;

SELECT 
    c.category_name AS Category, 
    SUM(st.revenue) AS Total_Revenue,
    SUM(st.profit) AS Total_Profit
FROM sales_transactions st
INNER JOIN products p ON st.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY Total_Revenue DESC;

SELECT 
    c.category_name AS Category,
    SUM(st.revenue) AS Total_Revenue,
    SUM(st.profit) AS Total_Profit,
    ROUND((SUM(st.profit) / SUM(st.revenue)) * 100, 2) AS Profit_Margin_Percentage
FROM sales_transactions st
INNER JOIN products p ON st.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY Profit_Margin_Percentage DESC;

SELECT 
    s.region AS Region,
    s.store_name AS Store_Name,
    SUM(st.revenue) AS Total_Revenue,
    SUM(st.profit) AS Total_Profit
FROM sales_transactions st
INNER JOIN stores s ON st.store_id = s.store_id
GROUP BY s.region, s.store_name
ORDER BY s.region, Total_Revenue DESC;