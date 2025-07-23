# Data_Analysis_Sales_Dashboard


## 🔷 Introduction
In today’s competitive business landscape, data-driven decision-making is not just an advantage—it’s a necessity. This Sales Dashboard project was designed to transform raw transactional sales data into meaningful insights using SQL for data extraction and Power BI for interactive visualization. By bridging the gap between data and action, the dashboard provides a real-time view into key business metrics such as total revenue, profit, orders, discounts, and category performance, across multiple dimensions including time, geography, store location, and payment method.

The goal of this project is to empower stakeholders with the tools they need to:

Understand sales trends and patterns at a glance,

Identify top-performing products, regions, and employees,

Track profitability and customer payment behavior, and

Make strategic business decisions grounded in data.

To enhance user experience, the dashboard incorporates interactive features such as dynamic filters, slicers, maps, animated GIFs, and visual storytelling, enabling users to explore insights intuitively and efficiently.
This project analyzes sales data from 6 different countries — India, US, UK, Canada, China, and Nigeria. It includes all steps from raw data cleaning, data modeling, and SQL querying to final interactive dashboard creation in Power BI.

This project demonstrates a comprehensive end-to-end approach—from data modeling and SQL query development, to visual analytics and storytelling—and showcases the power of business intelligence to drive measurable value.

## 🎯 Objective
The primary objective of this project was to perform an end-to-end Sales Data Analysis across six countries — India, US, UK, Canada, China, and Nigeria — in order to:

Clean and transform raw sales data for consistency and accuracy

Create a unified sales dataset using SQL

Extract meaningful business insights through data analysis queries

Build an interactive Power BI dashboard that empowers decision-makers to explore KPIs and patterns across products, locations, and timeframes.


## 🔧 Tools Used:
- Microsoft Excel (Power Query) – for initial data cleaning and formatting

- PostgreSQL – for data integration, cleaning, and transformation

- Power BI – for interactive visualizations and business insights

- Git – for version control and sharing



## 📚 Data Source
The dataset used in this project contains individual transactional sales records from six countries. It includes the following key columns:

Transaction ID (UUID) <br>
Date of purchase <br>
Country and Store Location <br>
Product details (ID, Name, Category) <br>
Price, Cost, Quantity, and Discount <br>
Customer demographics (Gender, Age Group) <br>
Sales Representative and Payment Method <br>

Data was originally in .csv format and cleaned in Excel (Power Query) before being imported into PostgreSQL.<br>
##### Link:
https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard


## 🛠️ Detailed Project Breakdown
### 🔸 1. Excel (Power Query) – Data Formatting & Preprocessing
📍 Work Done:
Standardized Date Format:

Raw sales data had inconsistent date formats (e.g., DD-MM-YYYY).

Using Power Query in Excel, transformed it into SQL-compatible YYYY-MM-DD format using:
##### Formula: Date.ToText([Date], "yyyy-MM-dd")

Fixed Data Errors: <br>
Identified and corrected errors such as: <br>
Invalid UUID format (e.g., line 276 in Nigeria file) <br>
Empty or corrupted rows <br>
Uniform Schema Across Countries: <br>
Ensured column headers and data types were consistent in all six files (India, US, UK, China, Canada, Nigeria)


Exported Clean Files:

Saved cleaned files for each country to be imported into SQL <br>
LINK: <br>
https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard/tree/main/Excel_Formatted_Files

### 🔸 2. PostgreSQL – Data Cleaning, Structuring & Analysis
📍 Work Done:
📁 Database Design:
Created individual tables: Sales_India, Sales_US, Sales_Canada, Sales_China, Sales_Nigeria, Sales_UK

Consistent schema with appropriate data types (e.g., UUID, NUMERIC, VARCHAR)

🔄 Data Consolidation:
Combined all country tables into a master table Sales_Data using UNION ALL

🧹 Data Cleaning: 
Identified and handled null values using WHERE ... IS NULL

Updated missing values (e.g., set Quantity_Purchased = 3 for a missing transaction)

Checked for and prevented duplicate records using GROUP BY ... HAVING COUNT(*) > 1

➕ Feature Engineering:
Added new calculated columns:

Total_Amount = (Price_per_Unit * Quantity_Purchased) - Discount_Applied

Profit = Total_Amount - (Cost_Price + Quantity_Purchased)<br>
https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard/blob/main/Sales_Project.sql
#### 📊 Business Analysis Report (SQL Queries):
Sales Revenue & Profit by Country <br>
Top 5 Best-Selling Products in the Last 7 Months <br>
Best Sales Representative Performance <br>
Highest Performing Store Locations <br>
Sales and Profit Summary Metrics (Min, Max, Avg) <br>
Check Out Here : https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard/blob/main/Sales_Project.sql
### Analysis and generates business insights

#### 1. Sales Revenue & Profit By Country
SELECT 
	Country,
	SUM(Total_Amount) AS Total_Revenue,
	SUM(Profit) AS Total_Profit
FROM Sales_Data
WHERE DATE BETWEEN '2025-02-10' and '2025-02-14'
GROUP BY Country
ORDER BY Total_Revenue DESC;
##### 🧾 Explanation:

This query provides a country-wise breakdown of revenue and profit for a specific week.

Helps identify which countries are top-performing markets and which ones need strategic attention.

##### 🔍 Use in Dashboard:

Supports visuals like bar charts and KPI cards showing total revenue/profit by region.

#### 2. Top 5 Best-Selling Products (Last 7 Months)

SELECT 
	Product_Name, 
	SUM(Quantity_Purchased) AS Total_Unit_Sold
FROM Sales_Data
WHERE Date BETWEEN '2025-01-27' and '2025-07-27'
GROUP BY Product_Name
ORDER BY Total_Unit_Sold DESC
LIMIT 5;
##### 🧾 Explanation:

Identifies the top 5 products with the highest units sold, showing customer demand trends.

Useful for inventory planning, promotions, and product strategy.

##### 🔍 Use in Dashboard:

Ideal for horizontal bar visuals or ranking lists to highlight best sellers.

#### 3. Best Sales Representatives (Last 7 Months)

SELECT 
	Sales_Rep,
	SUM(Total_Amount) AS Total_Sales
FROM Sales_Data
WHERE DATE BETWEEN '2025-01-27' and '2025-07-27'
GROUP BY Sales_Rep
ORDER BY Total_Sales
LIMIT 5;
#### 🧾 Explanation:

Evaluates the performance of sales reps based on total sales contribution.

Can be used in employee evaluation, performance bonuses, and team training planning.

###### 🔍 Use in Dashboard:

Fits well in bar or leaderboard-style visuals that encourage competition and recognition.

### 4. Store Locations with Highest Sales (Last 7 Months)
sql
Copy code
SELECT
	Store_Location,
	SUM(Total_Amount) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM Sales_Data
WHERE DATE BETWEEN '2025-01-27' and '2025-07-27'
GROUP BY Store_Location
ORDER BY Total_Sales
LIMIT 5;
#### 🧾 Explanation:

Highlights which physical stores are generating the most revenue and profit.

Helps in location-based strategy, resource allocation, and store expansion decisions.

###### 🔍 Use in Dashboard:

Represented using map visuals or bar charts showing profit vs sales by location.

### 5. Key Sales and Profit Insights (Summary Stats)

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

#### 🧾 Explanation:
Delivers key summary statistics across total amount and profit values. <br>
Helps stakeholders quickly understand how the business is performing during the selected time range.

###### 🔍 Use in Dashboard:

Supports KPI cards and summary visuals at the top of the dashboard (e.g., Total Sales, Profit, Discounts).

📥 Downloadable PDF Report<br>
https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard/blob/main/Project%20Report.pdf

📄 Click here to download Business Queries Report PDF


### 🔸 3. Power BI – Visualization & Dashboarding
📍 Work Done: <br>
📌 Dashboard KPIs: <br>
* Total Sales <br>
* Total Profit <br>
* Total Discounts <br>
* Total Orders <br>

#### 📈 Interactive Visuals:
Bar Chart: Total Sales by Category (e.g., Clothing, Electronics)

Pie Chart: Sales by Payment Method (Mobile, Credit, Cash)

Map Visualization: Sales by Store Location & Country

Enabled dynamic filtering by region

Scatter Plot: Discounts vs Profit by Country

Line Chart: Total Sales by Day (trend over time)

Bar Chart: Total Profit by Category

##### 📊 Visuals Breakdown:

| 🔍 Visual                                   | 📘 Description                                                                                               |
| ------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Total KPIs**                              | Show key metrics: `Total Sales`, `Total Profit`, `Total Orders`, `Total Discounts`                           |
| **Total Sales by Category**                 | Bar chart ranking product categories based on total sales. Highlights "Clothing" as top performer            |
| **Total Sales by Store Location & Country** | **Map visual** using geolocation data. Compares sales across global cities like Delhi, London, Toronto, etc. |
| **Total Sales by Payment Method**           | **Pie chart** representing distribution of sales via Cash, Credit, and Mobile payments                       |
| **Discounts Given vs. Profit**              | Scatter plot mapping discounts vs. profit, grouped by country. Useful for margin analysis                    |
| **Total Sales by Day**                      | Line graph tracking daily sales trends – helps identify peak sales days                                      |
| **Total Profit by Category**                | Bar chart showing how profit varies across categories. "Clothing" again leads in profitability               |


###### 🧭 Slicers for Interactivity:
 <br> Monthly selection (January to December) <br>
Filters for: <br>
Country <br>
Store Location <br>
Category <br>
Payment Method <br>

🌟 Enhancements:
Used GIF images to improve visual engagement <br>
Clean, intuitive layout to help stakeholders explore data quickly

##### ✅ Summary of Tools and Their Purpose:
| Tool         | Purpose                                                                    |
| ------------ | -------------------------------------------------------------------------- |
| **Excel**    | Data cleanup, fixing formatting issues, transforming date columns          |
| **SQL**      | Data storage, cleaning, transformation, analysis through business queries  |
| **Power BI** | Visual storytelling, KPI dashboards, trend analysis, stakeholder reporting |

link: https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard/blob/main/Sales_Dashboard.pbix


###### Take a look at Final Dashbord:<br>
https://github.com/Aarti07-spec/Data_Analysis_Sales_Dashboard/blob/main/Sales%20Dashboard_PNG.png


## 🧠 Learning Outcomes
Through this project, the following skills and concepts were developed:

##### 🔹 Excel (Power Query)
Data formatting and transformation (e.g., date format standardization)

Fixing errors in raw data (e.g., invalid UUIDs)

###### 🔹 SQL (PostgreSQL)
Table creation and schema design

Merging multiple datasets using UNION ALL

Null handling and data cleaning queries

Feature engineering (Total_Amount, Profit)

Business-focused SQL queries (Top products, Best reps, Sales trends)

##### 🔹 Power BI
Designing professional, interactive dashboards

Using slicers, maps, pie charts, and KPIs

Visual storytelling through clean and actionable visuals

Enhancing user engagement with GIFs and filters

## 📝 Conclusion 
This project successfully demonstrated a complete data analytics workflow starting from raw data handling to insight generation. The unified sales dataset helped uncover valuable insights like:

Top-selling and most profitable product categories (e.g., Clothing)

High-performing sales reps and store locations

Influence of discounts and payment methods on profitability

Seasonal and regional trends in sales performance

The final Power BI dashboard serves as an effective tool for executives and business analysts to interact with data and make informed decisions, highlighting the power of integrated tools (Excel + SQL + Power BI) in solving real-world business problems.


### 📬 Feedback & Contributions 
Have ideas for improving this dashboard or extending the analysis? Feel free to fork, raise issues, or submit PRs!

###### Contact: <br>
Lamkhade Aarti <br>
Email: aartilamkhade72@gmail.com 



# THANK YOU

