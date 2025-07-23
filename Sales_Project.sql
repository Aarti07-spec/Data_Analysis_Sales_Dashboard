-- Create Tables:

DROP TABLE IF EXISTS Sales_India;
CREATE TABLE Sales_India(
	Transaction_ID UUID PRIMARY KEY,
	Date DATE ,
	Country VARCHAR(50),
	Product_ID TEXT,
	Product_Name VARCHAR(50),
	Category VARCHAR(50),
	Price_per_Unit NUMERIC(10,2),
	Quantity_Purchased INTEGER,
	Cost_Price NUMERIC(10,2),
	Discount_Applied NUMERIC(10,2),
	Payment_Method VARCHAR(50),
	Customer_Age_Group VARCHAR(50),
	Customer_Gender VARCHAR(50),
	Store_Location VARCHAR(50),
	Sales_Rep VARCHAR(50)

);


DROP TABLE IF EXISTS Sales_US;
CREATE TABLE Sales_US(
	Transaction_ID UUID PRIMARY KEY,
	Date DATE ,
	Country VARCHAR(50),
	Product_ID TEXT,
	Product_Name VARCHAR(50),
	Category VARCHAR(50),
	Price_per_Unit NUMERIC(10,2),
	Quantity_Purchased INTEGER,
	Cost_Price NUMERIC(10,2),
	Discount_Applied NUMERIC(10,2),
	Payment_Method VARCHAR(50),
	Customer_Age_Group VARCHAR(50),
	Customer_Gender VARCHAR(50),
	Store_Location VARCHAR(50),
	Sales_Rep VARCHAR(50)

);

DROP TABLE IF EXISTS Sales_China;
CREATE TABLE Sales_China(
	Transaction_ID UUID PRIMARY KEY,
	Date DATE ,
	Country VARCHAR(50),
	Product_ID TEXT,
	Product_Name VARCHAR(50),
	Category VARCHAR(50),
	Price_per_Unit NUMERIC(10,2),
	Quantity_Purchased INTEGER,
	Cost_Price NUMERIC(10,2),
	Discount_Applied NUMERIC(10,2),
	Payment_Method VARCHAR(50),
	Customer_Age_Group VARCHAR(50),
	Customer_Gender VARCHAR(50),
	Store_Location VARCHAR(50),
	Sales_Rep VARCHAR(50)

);

DROP TABLE IF EXISTS Sales_Canada; 

CREATE TABLE Sales_Canada(
	Transaction_ID UUID PRIMARY KEY,
	Date DATE ,
	Country VARCHAR(50),
	Product_ID TEXT,
	Product_Name VARCHAR(50),
	Category VARCHAR(50),
	Price_per_Unit NUMERIC(10,2),
	Quantity_Purchased INTEGER,
	Cost_Price NUMERIC(10,2),
	Discount_Applied NUMERIC(10,2),
	Payment_Method VARCHAR(50),
	Customer_Age_Group VARCHAR(50),
	Customer_Gender VARCHAR(50),
	Store_Location VARCHAR(50),
	Sales_Rep VARCHAR(50)

);

DROP TABLE IF EXISTS Sales_UK;
CREATE TABLE Sales_UK(
	Transaction_ID UUID PRIMARY KEY,
	Date DATE ,
	Country VARCHAR(50),
	Product_ID TEXT,
	Product_Name VARCHAR(50),
	Category VARCHAR(50),
	Price_per_Unit NUMERIC(10,2),
	Quantity_Purchased INTEGER,
	Cost_Price NUMERIC(10,2),
	Discount_Applied NUMERIC(10,2),
	Payment_Method VARCHAR(50),
	Customer_Age_Group VARCHAR(50),
	Customer_Gender VARCHAR(50),
	Store_Location VARCHAR(50),
	Sales_Rep VARCHAR(50)

);

DROP TABLE IF EXISTS Sales_Nigeria;
CREATE TABLE Sales_Nigeria(
	Transaction_ID UUID PRIMARY KEY,
	Date DATE ,
	Country VARCHAR(50),
	Product_ID TEXT,
	Product_Name VARCHAR(50),
	Category VARCHAR(50),
	Price_per_Unit NUMERIC(10,2),
	Quantity_Purchased INTEGER,
	Cost_Price NUMERIC(10,2),
	Discount_Applied NUMERIC(10,2),
	Payment_Method VARCHAR(50),
	Customer_Age_Group VARCHAR(50),
	Customer_Gender VARCHAR(50),
	Store_Location VARCHAR(50),
	Sales_Rep VARCHAR(50)

);



-- import data by direct method

/* before importing data i did requird formatting for postgre sql in our raw data by using EXCEL.
1.Date format in raw data was "DD-MM-YYYY" which is not accepted in postgre sql 
to fix it, i had changed DATE format to valid format i.e. "YYYY-MM-DD" By using [formula := Date.ToText([Date], "yyyy-MM-dd")] 
 in EXCEL in POWER QUERY. 
2. Raw Data Nigeria sales file contains error at 276 number line FOR TRANSACTION_ID invalid UUID format fix it also in EXCEL.
*/


SELECT * FROM Sales_India;
SELECT * FROM Sales_US;
SELECT * FROM Sales_China;
SELECT * FROM Sales_Canada;
SELECT * FROM Sales_UK;
SELECT * FROM Sales_Nigeria;





-- UNION OF ALL TABLES

DROP TABLE IF EXISTS Sales_Data;

CREATE TABLE Sales_Data AS
SELECT * FROM Sales_Canada
UNION ALL
SELECT * FROM Sales_China
UNION ALL
SELECT * FROM Sales_India
UNION ALL
SELECT * FROM Sales_Nigeria
UNION ALL
SELECT * FROM Sales_UK
UNION ALL
SELECT * FROM Sales_US;

SELECT * FROM Sales_Data;

WHERE Quantity_Purchased IS NULL








-- Data cleaning and processing

SELECT * 
FROM Sales_Data
WHERE 
	Country IS NULL
	OR Price_per_Unit IS NULL
	OR Quantity_Purchased IS NULL
	OR Cost_Price IS NULL
	OR Discount_Applied IS NULL;



-- Handle null values
update sales_Data
set Quantity_Purchased = 3
where Transaction_id = '00a30472-89a0-4688-9d33-67ea8ccf7aea'


-- Check duplicate value

SELECT Transaction_ID, COUNT(*)
FROM Sales_Data
GROUP BY Transaction_ID
HAVING COUNT (*)>1;



--Add columns
-- 1.Total_Columns

ALTER TABLE Sales_Data ADD
COLUMN Total_Amount Numeric(10,2);

UPDATE Sales_Data
SET Total_Amount = (Price_per_Unit * Quantity_Purchased) - Discount_Applied;

SELECT * FROM Sales_Data;


--2.Profit

ALTER TABLE Sales_Data ADD
COLUMN Profit Numeric(10,2);

UPDATE Sales_Data
SET Profit = Total_Amount - (Cost_Price + Quantity_Purchased);

SELECT * FROM Sales_Data;



-- Analysis and generates business insights

--1. Sales Revenue & Profit By country

SELECT 
	Country,
	SUM(Total_Amount) AS Total_Revenue,
	SUM(Profit) AS Total_Profit
FROM Sales_Data
WHERE DATE BETWEEN '2025-02-10' and '2025-02-14'
GROUP BY Country
ORDER BY Total_Revenue DESC;


-- 2.Top 5 Best Selling Products in last 7 Months

SELECT 
	Product_Name, 
	SUM(Quantity_Purchased) AS Total_Unit_Sold
FROM Sales_Data
WHERE Date BETWEEN '2025-01-27' and '2025-07-27'
GROUP BY Product_Name
ORDER BY Total_Unit_Sold DESC
LIMIT 5;


-- 3. Best Sales Representative in last 7 months

SELECT 
	Sales_Rep,
	SUM(Total_Amount) AS Total_Sales
FROM Sales_Data
WHERE DATE BETWEEN '2025-01-27' and '2025-07-27'
GROUP BY Sales_Rep
ORDER BY Total_Sales
LIMIT 5;

--4. Which Store Locations generated the highest sales in last 7 months

SELECT
	Store_Location,
	SUM(Total_Amount) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM Sales_Data
WHERE DATE BETWEEN '2025-01-27' and '2025-07-27'
GROUP BY Store_Location
ORDER BY Total_Sales
LIMIT 5;

--5. What are the Key sales and profit insights for the selected period?

SELECT 
	MIN(Total_Amount) AS Min_Sales_value,
	MAX(Total_Amount) AS Max_Sales_value,
	AVG(Total_Amount) AS Avg_Sales_value,
	SUM(Total_Amount) AS Total_Sales,
	MIN(Profit) AS Min_Profit,
	Max(Profit) AS Max_Profit,	
	AVG(Profit) AS Avg_Profit,
	SUM(Profit) AS Sum_Profit
FROM Sales_Data
WHERE DATE BETWEEN '2025-01-27' and '2025-07-27'