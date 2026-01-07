/*
============================================================================
Product Report
============================================================================
Purpose:
	- This report consolidates key customer metrics and behaviours

Highlights:
	1. Gathers essential fields such as product name, category, subcategory, and cost.
	2. Segments products into revenue to identify High-Performers, Mid-Range or Low-Perfromers.
	3. Aggregates product-level metrics:
		- total orders
		- total sales
		- total quantity sold
		- total customers (unique)
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
==============================================================================
*/
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
  DROP VIEW

GO
  
CREATE VIEW gold.report_products AS

  WITH base_query AS (
SELECT
	f.order_number,
	f.order_date,
	f.sales_amount,
	f.quantity,
	f.customer_key,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON	p.product_key = f.product_key
WHERE f.order_date IS NOT NULL
)

/*--------------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------------*/

,product_aggregation AS (
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity_sold,
	ROUND(AVG(sales_amount/NULLIF(quantity, 0)), 1) AS avg_selling_price
FROM base_query
GROUP BY product_key, product_name, category, subcategory, cost
)

-- Final Query
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(month, last_sale_date, GETDATE()) AS recency_in_months,
	CASE WHEN total_sales > 50000 THEN 'High Performer'
		 WHEN total_sales >= 10000 THEN 'Mid-Performer'
		 ELSE 'Low-Performer'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity_sold,
	total_customers,
	avg_selling_price,
	-- Average Order Revenue (AOR)
	CASE WHEN total_orders = 0 THEN 0
		 ELSE total_sales/total_orders 
	END AS avg_order_value,
	-- Compute average monthly spend
	CASE WHEN lifespan = 0 THEN total_sales
		 ELSE total_sales/ lifespan
	END AS avg_monthly_spend
FROM product_aggregation




