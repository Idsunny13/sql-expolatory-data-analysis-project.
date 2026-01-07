/*
===============================================================================================================
Measures Exploration

Purpos:
  - To calculate the key metrics of the business (big number).
  - To show the highest level of aggregation/ lowest level of details.
===============================================================================================================
*/

-- Total sales
SELECT 
	SUM(sales_amount) AS total_sales 
FROM gold.fact_sales

-- Number of items sold
SELECT
	SUM(quantity) AS items_sold 
FROM gold.fact_sales

-- Average selling price
SELECT 
	AVG(price) AS avg_price 
FROM gold.fact_sales

-- Total number of orders
SELECT 
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales

-- Total number of products
SELECT
	COUNT(DISTINCT product_name) AS total_products
FROM gold.dim_products

-- Total number of customers
SELECT 
	COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customers


-- Total number of customers that placed an order
SELECT 
	COUNT(DISTINCT customer_key) AS total_customers_order
FROM gold.fact_sales


-- Generate a Report that show all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Average Price', AVG(price) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Total Number of Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION
SELECT 'Total Number of Products', COUNT(product_name) FROM gold.dim_products
UNION
SELECT 'Total Number of Customers', COUNT(customer_key) FROM gold.dim_customers



