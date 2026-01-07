/*
=============================================================================================================
Data Segmentation

Purpose:
  - To group the data based on a specific range.
  - To help understand the correlation between two measures.
=============================================================================================================
*/

-- Segmenting products into cost ranges and counting how many products fall into each segment
WITH product_segment AS (
SELECT
	product_key,
	product_name,
	CASE WHEN cost < 100 THEN 'Below 100'
		 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		 ELSE 'Above 1000'
	END cost_range
FROM gold.dim_products
)

SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC

-- Grouping customers by their spending behaviour
WITH customer_class AS (
SELECT
	c.customer_key,
	CASE WHEN (DATEDIFF(month, MIN(order_date), MAX(order_date)) >= 12) AND SUM(sales_amount) > 5000 THEN 'VIP'
		 WHEN (DATEDIFF(month, MIN(order_date), MAX(order_date)) >= 12) AND SUM(sales_amount) <= 5000 THEN 'Regular'
		 ELSE 'New'
	END AS spending_class
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON	c.customer_key = f.customer_key
GROUP BY c.customer_key
)

SELECT
	spending_class,
	COUNT(*) AS number_count
FROM customer_class
GROUP BY spending_class
ORDER BY number_count DESC
