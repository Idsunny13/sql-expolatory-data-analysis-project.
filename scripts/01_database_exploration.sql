/*
====================================================================================================
Database Exploration

Purpose:
  This is a short query written for the prupose of showing/seeing every table in our database and also all 
  the columns in these tables
====================================================================================================
*/
-- For showing the tables in your database
SELECT 
  * 
FROM INFORMATION_SCHEMA.TABLES

-- For showing the columns in each table in the database
SELECT 
  * 
FROM INFORMATION_SCHEMA.COLUMNS
