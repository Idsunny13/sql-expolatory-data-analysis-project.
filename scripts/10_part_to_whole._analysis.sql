/*
====================================================================================================
Part-to-whole analysis

Purpose:
  - To analyze how an individual part is performing comapared to the overall.
  - To allow us understand which category has the greatest impact on the business.
====================================================================================================
*/
-- Categories that contribute the most to overall sales
WITH category_sales AS (
SELECT
	category,
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY category
)

SELECT
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER() * 100), 2), + '%') AS percentage_of_total
FROM category_sales
ORDER BY percentage_of_total DESC
