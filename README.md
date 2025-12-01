# 🚀 Project Overview
![Image]

This project analyzes customer shopping behavior using SQL, Power BI, and Python-based clustering.
We explored purchase patterns, discount usage, revenue trends, and demographic insights to generate data-driven marketing strategies for the business.

---

# 🧩 Objectives

- 1.Identify product categories where discounts should be applied.
- 2.Analyze card spending patterns across age groups.
- 3.Explore the impact of seasons and locations on customer spending.
- 4.Segment customers using K-Means clustering.
- 5.Provide targeted marketing recommendations based on cluster behavior.
---

# 🛠️ Tech Stack

- SQL (MySQL Workbench) — Data Extraction & Trend Analysis

- Power BI — Interactive Dashboards & Visualizations

- Python (Pandas, Scikit-learn) — Customer Segmentation (K-Means)

- Excel — Pre-processing & Data Verification
---

# 📁 Key Deliverables

- 📌 SQL Query Scripts
- 📌 Power BI Dashboard (3 Pages)
- 📌 Python Clustering Notebook
- 📌 Insights & Marketing Recommendations
- 📌 Final Presentation (PPT)
---


# SQL Scripts 
**Product Category Discount Analysis**

1.Discount Usage by Category
```sql
SELECT 
    Category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) AS discount_orders,
    ROUND(SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS discount_percentage
FROM shopping_table
GROUP BY Category
ORDER BY discount_percentage DESC;
```

2.Category-Wise Performance (Sales Strength)
```sql
SELECT 
    Category,
    COUNT(*) AS total_orders,
    AVG(Purchase_Amount_USD) AS avg_purchase,
    SUM(Previous_Purchases) AS past_purchase_count
FROM shopping_table
GROUP BY Category
ORDER BY avg_purchase ASC;
```

3.Frequency of Discount vs Promo Usage
```sql
SELECT 
    Category,
    SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) AS discount_used,
    SUM(CASE WHEN Promo_Code_Used = 'Yes' THEN 1 ELSE 0 END) AS promo_used
FROM shopping_table
GROUP BY Category
ORDER BY discount_used DESC;
```

4.Most Profitable vs Least Profitable Categories
```sql
SELECT 
    Category,
    SUM(Purchase_Amount_USD) AS total_revenue,
    AVG(Purchase_Amount_USD) AS avg_purchase_value
FROM shopping_table
GROUP BY Category
ORDER BY total_revenue DESC;
```

**Age, Season & Location Spending Analysis**
1.Card Spending Based on Age Groups
```sql
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
```

2.Age Group Total Spending
```sql
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
```

3.Season-wise Spending & Orders
```sql
SELECT 
    Season,
    COUNT(*) AS total_orders,
    SUM(Purchase_Amount_USD) AS total_revenue,
    AVG(Purchase_Amount_USD) AS avg_order_value
FROM shopping_table 
GROUP BY Season
ORDER BY total_revenue DESC;
```

4. Location-wise Revenue
```sql
SELECT 
    Location,
    COUNT(*) AS total_orders,
    SUM(Purchase_Amount_USD) AS total_revenue,
    AVG(Purchase_Amount_USD) AS avg_order_value
FROM shopping_table
GROUP BY Location
ORDER BY total_revenue DESC;
```

5.Age × Season Spending Pattern
```sql
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
```

**Extract Data for Clustering**
```sql
SELECT 
    Age,
    Purchase_Amount_USD AS purchase_amount,
    Previous_Purchases AS previous_purchases,
    Review_Rating AS review_rating,
    CASE WHEN Subscription_Status = 'Yes' THEN 1 ELSE 0 END AS subscription,
    CASE WHEN Promo_Code_Used = 'Yes' THEN 1 ELSE 0 END AS promo_used,
    CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END AS discount_used
FROM shopping_table;
```

---

# 📊 Analysis Summary
**🔹 Part A — Product Category Discount Analysis**
- Identified categories with low average purchase value and high promo responsiveness.
- Suggested targeted discount strategies to boost underperforming categories.
- Highlighted profitable categories where discounts can be minimized.
![Image]

**🔹 Part B — Age, Season & Location Insights**
- Card spending varies significantly across age groups.
- Seasonal spending trends reveal peak revenue periods.
- Location analysis identifies high-performing regions for targeted campaigns.
![Image]

**🔹 Part C — Customer Segmentation (K-Means) Grouped customers into 3 distinct clusters:**
- Deal Seekers — Highly price-sensitive, depend on offers
- Full Price Buyers — Consistent spenders, low offer dependency
- Loyal Subscribers — High engagement, repeat buyers
- Generated personalized marketing strategies for each cluster.
![Image]
---

# 🎯 Final Strategic Recommendations
- Focus discounts on categories with weak performance but high response to promos.
- Deploy age-based payment and product campaigns for improved conversion.
- Prioritize high-revenue locations for premium promotions.
- Use cluster-based targeting to improve retention and campaign ROI.
---

# 👥 Team Contribution
This project was completed collaboratively as part of a client-based analytics assignment, involving end-to-end data analysis, dashboard development, and machine learning segmentation.

---
