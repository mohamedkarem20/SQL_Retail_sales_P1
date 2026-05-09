--SQl Ratail Sales Analysis - p1
CREATE DATABASE project_1;


USE project_1;


--Crate Table

DROP table IF EXISTS Ratail_Sales;
CREATE TABLE Ratail_Sales
       ( 
	      transactions_id INT PRIMARY KEY,
		  sale_date	DATE,
		  sale_time TIME,
		  customer_id INT, 
		  gender VARCHAR(15),
		  age INT,
		  category VARCHAR(15),
		  quantiy INT,
		  price_per_unit FLOAT,
		  cogs FLOAT,
		  total_sale FLOAT
		  );


----insert Data
BULK INSERT Ratail_Sales
    FROM 'C:\Users\Admin\Desktop\SQL - Retail Sales Analysis_utf  (1).csv'
	WITH  (
	       fieldterminator = ',',
		   rowterminator = '\n',
		   firstrow = 2
		    );

select *
FROM Ratail_Sales;


select Top (50) *
FROM Ratail_Sales
ORDER BY  transactions_id DESC;


select count (*)
FROM Ratail_Sales;


=========================================================================
----DATA Cleaning
=========================================================================


select * 
FROM Ratail_Sales
WHERE
     transactions_id IS Null
     OR
     sale_date IS Null
     OR
     sale_time IS Null
     OR
     customer_id IS Null 
     OR
     gender IS Null
     OR
     age IS Null
     OR
     category IS Null
     OR
     quantiy IS Null
     OR
     price_per_unit IS Null
     OR
     cogs IS Null
     OR
     total_sale IS Null;
	 




DELETE FROM Ratail_Sales
WHERE
     transactions_id IS Null
     OR
     sale_date IS Null
     OR
     sale_time IS Null
     OR
     customer_id IS Null 
     OR
     gender IS Null
     OR
     age IS Null
     OR
     category IS Null
     OR
     quantiy IS Null
     OR
     price_per_unit IS Null
     OR
     cogs IS Null
     OR
     total_sale IS Null;



=========================================================================
----DATA Exploration	 
========================================================================= 



--How many sales we have
select count(*)
as total_sale 
from Ratail_Sales;

--How many customers we have
select count(*)
as customer_id 
from Ratail_Sales;


--How many  unique customers we have
select count( DISTINCT customer_id)
as  total_sale 
from Ratail_Sales;

--How many  unique category we have
select count( DISTINCT category)
as  total_sale 
from Ratail_Sales;
--name
select  DISTINCT category
as  total_sale 
from Ratail_Sales;


=========================================================================
----Data Analysis & Business Key Problems & Answers
=========================================================================

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * 
FROM Ratail_Sales
WHERE sale_date ='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
FROM Ratail_Sales
WHERE
category  ='Clothing'
AND
quantiy >= 4
AND
sale_date BETWEEN '2022-11-1' AND '2022-12-1';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,
       sum (total_sale) as net_sales
from Ratail_Sales
GROUP BY category ;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
     ROUND(AVG (age),2) as AVG_age
from Ratail_Sales
WHERE category= 'Beauty' ;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * 
from Ratail_Sales
WHERE total_sale > 1000 ;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category ,
		gender,
       count(*) as  total_number 
from Ratail_Sales
GROUP BY 
        category ,
		gender
ORDER BY 1;        ---ORDER BY (1/category) 



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
      YEAR(sale_date) as year,
	  MONTH(sale_date) as month,
	  AVG(total_sale) as avg_sale
from Ratail_Sales
GROUP BY
         MONTH(sale_date),
		 YEAR(sale_date)
ORDER BY 1,2,3 ;                                --DESC لازم اشيل 2 الشهر علشان يعمل تنازلي



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top(5)
      customer_id,
	  sum(total_sale) as net_sale
FROM Ratail_Sales
GROUP BY  
      customer_id
ORDER BY 2  DESC
;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.  
select 
       category,
	   count(DISTINCT customer_id) as unique_customer
FROM 
     Ratail_Sales
GROUP BY
     category;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
as
(
select*,
     CASE
	      WHEN DATEPART (HOUR , sale_time) <12 THEN 'Morning'
		  WHEN DATEPART(HOUR , sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		  ELSE 'Evening'
      END as shift
FROM 
    Ratail_Sales
)

select
      shift,
      count(*) as total_order 
from hourly_sale
GROUP BY shift;


---END PROJECT