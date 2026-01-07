/*
===========================================================================================
Dimension Exploration

Purpose:
  - To identify the unique values/categories in each dimension
  - To help in recognizing how data can be grouped or segmented
===========================================================================================
*/

-- Explore the countries of the customers for this business
SELECT 
  DISTINCT country 
FROM gold.dim_products

-- Exploring all major categories
SELECT 
  DISTINCT 
    category, 
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY category, subcategory, product_name
