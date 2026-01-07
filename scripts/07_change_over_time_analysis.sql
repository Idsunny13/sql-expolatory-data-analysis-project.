/*
====================================================================================================
Changes over time Analysis (trends)

Purpose:
  - To analyze how a measure evolves over time.
  - To track trends and identify seasonality in our data.
====================================================================================================
*/

-- Number of new customers added each year
SELECT
	YEAR(create_date) AS create_year,
	COUNT(customer_key) as total_customer
FROM gold.dim_customers
GROUP BY YEAR(create_date)
ORDER BY YEAR(create_date)

-- Changes over the months
SELECT
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date) 
ORDER BY MONTH(order_date)

-- Changes over the years
SELECT
	YEAR(order_date) AS order_year,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date)
