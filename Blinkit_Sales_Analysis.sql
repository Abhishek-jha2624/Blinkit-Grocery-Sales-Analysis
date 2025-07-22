-- 1. Creating the data base 
CREATE DATABASE BLINKIT_PROJECT;

-- 2. Using the data from the database
USE BLINKIT_PROJECT;

-- 3. Checking wether all the rows and column are inported succesfully
select count(*) from blinkit;

-- 4. Data Cleaning 
-- Changing the miss spelling and all in the column

UPDATE blinkit
SET Item_Fat_Content = 
  CASE 
    WHEN Item_Fat_Content IN ('lf', 'low fat') THEN 'Low Fat'
    WHEN Item_Fat_Content = 'reg' THEN 'Regular'
    ELSE Item_Fat_Content
  END;
  
  -- checking value change or not
select distinct(Item_Fat_Content) from blinkit;

-- 5. Data Analyzing 
-- KPI Requirement 
-- Total sales 
select cast(sum(Total_Sales)/1000000 as decimal(10,2)) as Total_sales_in_millions 
from blinkit;

-- Average sales
select cast(avg(Total_Sales) as decimal(10,0)) as avg_sales
from blinkit;

-- Number of iteam
select count(*) as num_iteam
 from blinkit;
 
 -- Average Rating
select cast(avg(Rating) as decimal(10,2)) as avg_Rating
from blinkit;

-- Granular Requirement
-- Total sales or Additional matrix (avg sales,num of iteam,avg rating) by fat content
select Item_Fat_Content, 
cast(sum(Total_Sales)%1000 as decimal(10,2)) as Total_Sales,
cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
count(*) No_of_iteam,
cast(avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit
group by Item_Fat_Content
order by Total_Sales desc;

-- Total sales or Additional matrix (avg sales,num of iteam,avg rating) by Iteam Type
select Item_Type, 
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales,
cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
count(*) No_of_iteam,
cast(avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit
group by Item_Type
order by Total_Sales desc;

-- Total sales or Additional matrix (avg sales,num of iteam,avg rating) by Outlet_Establishment_Year
select Outlet_Establishment_Year, 
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales,
cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
count(*) No_of_iteam,
cast(avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit
group by Outlet_Establishment_Year
order by Total_Sales desc;

-- Fat content by outlet by total Total sales or Additional matrix (avg sales,num of iteam,avg rating)
select Outlet_Location_Type, Item_Fat_Content,
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales,
cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
count(*) No_of_iteam,
cast(avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit
group by Item_Fat_Content, Outlet_Location_Type
order by Total_Sales desc;

-- Other Business Requirement
-- Percentage of sales by Outlet size
select Outlet_Size, 
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales_1,
cast((sum(Total_Sales) * 100 / sum(sum(Total_Sales)) over()) as decimal(10,2) ) as Sales_percentage
from blinkit
group by Outlet_Size 
order by Sales_percentage desc;

-- Total Sales and Additional information by outlet location
select Outlet_Location_Type,
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales,
cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
count(*) No_of_iteam,
cast(avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit
group by Outlet_Location_Type
order by Total_sales desc;

-- All the  matrix by outlet Type
select Outlet_Type,
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales,
cast((sum(Total_Sales) * 100 / sum(sum(Total_Sales)) over()) as decimal(10,2) ) as Sales_percentage,
cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
count(*) No_of_iteam,
cast(avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit
group by Outlet_Type
order by Total_sales desc;







