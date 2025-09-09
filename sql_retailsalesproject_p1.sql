Use retailsalesdb
SELECT*FROM sales;

-- Data Cleaning
SELECT Count(*) FROM sales; 

SELECT * FROM sales 
WHERE transactions_id is NULL
OR 
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantiy is NULL
OR
price_per_unit is NULL
OR
cogs is NULL
OR
total_sale is NULL;

DELETE FROM sales
WHERE transactions_id is NULL
OR 
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantity is NULL
OR
price_per_unit is NULL
OR
cogs is NULL
OR
total_sale is NULL;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(total_sale) FROM sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM sales;

SELECT DISTINCT category FROM sales;

-- Data Analysis & Business Key Problem & Answers
-- 1.	Write a SQL query to retrieve all columns for sales made on '2022-11-05:
-- 2.	Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
-- 3.	Write a SQL query to calculate the total sales (total_sale) for each category.:
-- 4.	Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
-- 5.	Write a SQL query to find all transactions where the total_sale is greater than 1000.:
-- 6.	Write a SQL query to find the total number of transactions made by each gender in each category.:
-- 7.	Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
-- 8.	Write a SQL query to find the top 5 customers based on the highest total sales :
-- 9.	Write a SQL query to find the number of unique customers who purchased items from each category.:
-- 10.	Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


-- 1.	Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT*FROM sales
WHERE sale_date = '2022-11-05';

-- 2.	Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND sale_date >= '2022-11-01'
  AND sale_date <= '2022-11-30';

  -- 3.	Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT DISTINCT category, SUM(total_sale) AS grand_total 
FROM sales
GROUP BY category ORDER BY grand_total DESC;

-- 4.	Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT category, ROUND(AVG(age),2) AS Avg_Age
FROM sales
WHERE category = 'Beauty'
GROUP BY category;

-- 5.	Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT transactions_id, SUM(total_sale) AS Grand_total
FROM sales
WHERE total_sale>= '1000'
GROUP BY transactions_id;

-- 6.	Write a SQL query to find the total number of transactions made by each gender in each category.:
SELECT DISTINCT category, gender, COUNT(transactions_id) AS total_transcation
FROM sales
GROUP BY category, gender;

-- 7.	Write a SQL query to calculate the total sale for each month. Find out best selling month in each year:

  SELECT  Sales_Year,
    Sales_Month,
    Monthly_Total_Sales
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

 -- 8.	Write a SQL query to find the top 5 customers based on the highest total sales :
SELECT Top 5 Customer_id, 
       SUM(total_sale) AS Total_Sale
       FROM sales
GROUP BY customer_id ORDER BY Total_Sale DESC;

-- 9.	Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id)
FROM sales
GROUP BY category;

-- 10.	Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

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

-- End of Project