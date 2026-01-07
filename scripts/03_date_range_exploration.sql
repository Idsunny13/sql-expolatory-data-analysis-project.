/*
=================================================================================================
Date range exploration

Purpose:
  - To identify the earliest and latest dates (boundary).
  - To understand the scope of data and the lifespan.
=================================================================================================
*/

-- The date of the first and last order
-- Number of years of sales
SELECT 
	MIN(order_date) AS first_order_date, 
	MAX(order_date) AS last_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales


-- The age of the youngest and oldest customer
SELECT 
	MIN(birthdate) AS oldest_customer,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS youngest_customer,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
