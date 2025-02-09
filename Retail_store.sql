-- SQL Retal Sales analysis
Create database sql_project_p2

--Create Table
Drop table retail_sales
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

-- Data Importing

select * from retail_sales;
select count(*) from retail_sales;
select count(Distinct customer_id) from retail_sales;

-- Data Cleaning
select * from retail_sales
where 
     transaction_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

-- Remove null value
Delete from retail_sales
where 
     transaction_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many uniuque customers we have ?
select count(Distinct customer_id) from retail_sales;

-- How many uniuque catrgory we have ?
Select Distinct category from retail_sales;

 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'?
select * 
from retail_sales
where sale_date = '2022-11-05'; 

-- Q.2 Write a SQL query to retrieve all transactions from the retail_sales table where the category is 'Clothing', the quantity sold is at least 4, and the transactions occurred in November 2022?
select * 
from retail_sales
where
     category ='clothing'
	 And
	 To_char(sale_date, 'YYYY-MM') ='Nov-2022'
	 And
	 quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (net_sale) and the total number of orders (total_orders) for each category in the retail_sales table?
select category,
       sum(total_sale) as net_sale,
	   count(*) as total_order
from retail_sales 
group by 1;

-- Q.4 Write a SQL query to calculate the average age of customers who made purchases in the 'Beauty' category from the retail_sales table?
select round(Avg(age),2) as avg_age
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to retrieve all records from the retail_sales table where the total_sale exceeds 1000?
select *
from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to calculate the total number of transactions (transaction_id) for each gender within each category?
select category,
       gender,
	   count(*) as total_trans
from retail_sales
group by category, gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales?
select 
       customer_id,
       Sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category?
select 
      category,
      count(distinct customer_id) as unique_cust
from retail_sales
group by category ;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;







