-- Check All Tables in the Database
SHOW TABLES;

-- View Table Structure
describe shoping_table;
describe shopping_table;

-- View First 10 Rows
SELECT * FROM shopping_table;

-- Check Count of Records
SELECT COUNT(*) FROM shopping_table;

-- Check Data Types More Clearly
SHOW FULL COLUMNS FROM shopping_table;

-- Check for Missing Values in Each Column
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS customer_null,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS age_null,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS gender_null,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS category_null,
    SUM(CASE WHEN Purchase_Amount_USD IS NULL THEN 1 ELSE 0 END) AS purchase_null,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS location_null,
    SUM(CASE WHEN Season IS NULL THEN 1 ELSE 0 END) AS season_null,
    SUM(CASE WHEN Discount_Applied IS NULL THEN 1 ELSE 0 END) AS discount_null
FROM shopping_table;

-- Check Unique Values
SELECT DISTINCT Category FROM shopping_table;

SELECT DISTINCT Season FROM shopping_table;

SELECT DISTINCT Payment_Method FROM shopping_table;

SELECT DISTINCT Frequency_of_Purchases FROM shopping_table;

SELECT DISTINCT Gender FROM shopping_table;

SELECT DISTINCT Location FROM shopping_table;

-- Check Summary Statistics of Numerical Columns
SELECT 
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    AVG(Age) AS avg_age,
    MIN(Purchase_Amount_USD) AS min_purchase,
    MAX(Purchase_Amount_USD) AS max_purchase,
    AVG(Purchase_Amount_USD) AS avg_purchase,
    AVG(Previous_Purchases) AS avg_prev_purchases
FROM shopping_table;

-- Detect Outliers (Optional but Good Practice)
-- High Purchase Amount Outliers
SELECT * 
FROM shopping_table
WHERE Purchase_Amount_USD > (SELECT AVG(Purchase_Amount_USD) + 3 * STD(Purchase_Amount_USD) FROM shopping_table);

-- Get Total Revenue + Total Customers
SELECT 
    SUM(Purchase_Amount_USD) AS total_revenue,
    COUNT(DISTINCT Customer_ID) AS unique_customers
FROM shopping_table;

-- Product Category Discount Analysis
-- 1.Discount Usage by Category
SELECT 
    Category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) AS discount_orders,
    ROUND(SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS discount_percentage
FROM shopping_table
GROUP BY Category
ORDER BY discount_percentage DESC;

-- 2.Category-Wise Performance (Sales Strength)
SELECT 
    Category,
    COUNT(*) AS total_orders,
    AVG(Purchase_Amount_USD) AS avg_purchase,
    SUM(Previous_Purchases) AS past_purchase_count
FROM shopping_table
GROUP BY Category
ORDER BY avg_purchase ASC;

-- 3.Frequency of Discount vs Promo Usage
SELECT 
    Category,
    SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) AS discount_used,
    SUM(CASE WHEN Promo_Code_Used = 'Yes' THEN 1 ELSE 0 END) AS promo_used
FROM shopping_table
GROUP BY Category
ORDER BY discount_used DESC;

-- 4.Most Profitable vs Least Profitable Categories
SELECT 
    Category,
    SUM(Purchase_Amount_USD) AS total_revenue,
    AVG(Purchase_Amount_USD) AS avg_purchase_value
FROM shopping_table
GROUP BY Category
ORDER BY total_revenue DESC;


-- Age, Season & Location Spending Analysis
-- 1.Card Spending Based on Age Groups
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    Payment_Method,
    COUNT(*) AS total_transactions,
    SUM(Purchase_Amount_USD) AS total_spend,
    AVG(Purchase_Amount_USD) AS avg_order_value
FROM shopping_table
GROUP BY age_group, Payment_Method
ORDER BY age_group, total_spend DESC;

-- 2.Age Group Total Spending
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    SUM(Purchase_Amount_USD) AS total_spend
FROM shopping_table
GROUP BY age_group
ORDER BY total_spend DESC;

-- 3.Season-wise Spending & Orders
SELECT 
    Season,
    COUNT(*) AS total_orders,
    SUM(Purchase_Amount_USD) AS total_revenue,
    AVG(Purchase_Amount_USD) AS avg_order_value
FROM shopping_table 
GROUP BY Season
ORDER BY total_revenue DESC;

-- 4. Location-wise Revenue
SELECT 
    Location,
    COUNT(*) AS total_orders,
    SUM(Purchase_Amount_USD) AS total_revenue,
    AVG(Purchase_Amount_USD) AS avg_order_value
FROM shopping_table
GROUP BY Location
ORDER BY total_revenue DESC;

-- 5.Age × Season Spending Pattern
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    Season,
    SUM(Purchase_Amount_USD) AS total_spend
FROM shopping_table
GROUP BY age_group, Season
ORDER BY age_group, total_spend DESC;


-- Extract Data for Clustering
SELECT 
    Age,
    Purchase_Amount_USD AS purchase_amount,
    Previous_Purchases AS previous_purchases,
    Review_Rating AS review_rating,
    CASE WHEN Subscription_Status = 'Yes' THEN 1 ELSE 0 END AS subscription,
    CASE WHEN Promo_Code_Used = 'Yes' THEN 1 ELSE 0 END AS promo_used,
    CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END AS discount_used
FROM shopping_table;




















