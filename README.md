
# Retail Sales Analysis using SQL

## Project Overview
This project involves a comprehensive analysis of a retail sales dataset using SQL. The primary goal is to extract actionable insights from the sales data to understand customer behavior, identify sales trends, and evaluate product performance. The process includes data cleaning to ensure data integrity, exploratory data analysis to summarize key characteristics, and in-depth analysis to answer critical business questions.

## Objective
The core objective of this analysis is to leverage SQL querying to answer key business questions and provide data-driven insights. The specific goals were to:

Analyze sales performance for specific time periods and product categories.

Calculate aggregate sales metrics, such as total revenue per product category, to identify top-performing lines.

Segment customers by demographics (age, gender) and purchasing behavior to understand the customer base.

Identify the Top 5 most valuable customers based on their total spending to inform marketing and loyalty strategies.

Determine the busiest sales periods by breaking down sales by month and time of day (Morning, Afternoon, Evening) to optimize staffing and promotions.

Evaluate customer engagement by calculating the number of unique customers for each product category.

### 1. Retrieve all columns for sales made on '2022-11-05'.
```sql
SELECT * FROM sales
WHERE sale_date = '2022-11-05';
```
### 2. Retrieve all transactions in the 'Clothing' category where the quantity sold is more than 4 in November 2022.

```SQL
SELECT *
FROM sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND sale_date >= '2022-11-01'
  AND sale_date <= '2022-11-30';
  ```
### 3. Calculate the total sales for each product category.
```SQL

SELECT DISTINCT category, SUM(total_sale) AS grand_total
FROM sales
GROUP BY category ORDER BY grand_total DESC;
```
### 4. Find the average age of customers who purchased items from the 'Beauty' category.

```SQL

SELECT category, ROUND(AVG(age),2) AS Avg_Age
FROM sales
WHERE category = 'Beauty'
GROUP BY category;
```
### 5. Find all transactions where the total sale is greater than or equal to 1000.

```SQL

SELECT transactions_id, SUM(total_sale) AS Grand_total
FROM sales
WHERE total_sale >= '1000'
GROUP BY transactions_id;
```
### 6. Find the total number of transactions made by each gender in each category.

```SQL

SELECT DISTINCT category, gender, COUNT(transactions_id) AS total_transcation
FROM sales
GROUP BY category, gender;
```
### 7. Determine the best-selling month for each year based on total sales.

```SQL

SELECT Sales_Year, Sales_Month, Monthly_Total_Sales
FROM (
    SELECT
        YEAR(sale_date) AS Sales_Year,
        MONTH(sale_date) AS Sales_Month,
        SUM(total_sale) AS Monthly_Total_Sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS Rank_by_Month
    FROM
        sales
    GROUP BY
        YEAR(sale_date),
        MONTH(sale_date)
) AS MonthlyRankedSales
WHERE
    Rank_by_Month = 1
ORDER BY
    Sales_Year;
```

### 8. Find the top 5 customers based on the highest total sales.

```SQL

SELECT TOP 5 customer_id,
       SUM(total_sale) AS Total_Sale
       FROM sales
GROUP BY customer_id ORDER BY Total_Sale DESC;
```

### 9. Find the number of unique customers who purchased items from each category.

```SQL

SELECT category, COUNT(DISTINCT customer_id)
FROM sales
GROUP BY category;
```

### 10. Calculate the number of sales occurring in different time shifts (Morning, Afternoon, Evening).

```SQL

SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) >= 12 AND DATEPART(HOUR, sale_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS Number_of_Sales
FROM
    sales
GROUP BY
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) >= 12 AND DATEPART(HOUR, sale_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
    ```
