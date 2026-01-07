/*
==================================================================================================
Ranking Analysis

Purpose:
  - Orders the value of dimensions by measure
  - To identify Top N performers/ bottom N performers
==================================================================================================
*/

-- Top 5 product that generated the highest revenue
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS Total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY Total_revenue DESC

-- Top 5 worst performing product
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS Total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY Total_revenue 

-- Using windows function
SELECT
	*
FROM(
	SELECT 
		p.product_name,
		SUM(f.sales_amount) AS Total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name) t
WHERE rank_products <= 5

-- Top 10 customers with the highest revenue
SELECT TOP 10
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON	s.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC

-- Top 3 customers with the fewest orders
SELECT TOP 3
	c.customer_id,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON	s.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY orders





