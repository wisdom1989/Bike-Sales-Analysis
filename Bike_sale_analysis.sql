use bike_sales_db;

select * from bike_sales;

/*-----------------------------------------------------------------------------------------------------------------*/
-- How many country, state, product, product_category
SELECT count(distinct country) as 'Number_of_Country'
FROM bike_sales;

SELECT count(distinct state) as 'Number_of_States'
FROM bike_sales;

SELECT count(distinct Product) as 'Number_of_Products'
FROM bike_sales;

SELECT count(distinct Product_category) as 'Number_of_Product_category'
FROM bike_sales;

-- What are the unique country names
select distinct country 
from bike_sales;

-- What are the product category with names
SELECT Product, product_category
FROM bike_sales; 

-- Replace M to male and F to female
update bike_sales 
set customer_gender = 'male'
where customer_gender = 'm';

update bike_sales 
set customer_gender = 'female'
where customer_gender = 'F';

-- Age distribution of customers
select distinct age_group as age_distribution
from bike_sales;

-- select top 5 most profitable year
select date, year, profit
from bike_sales
order by profit desc
limit 5;

-- select top 5 most profitable month
select date, month, profit
from bike_sales
order by profit desc
limit 5;

-- Which gender have the most orders
select customer_gender, sum(order_quantity) as 'no_of_orders'
from bike_sales
group by customer_gender
order by 'no_of_orders' desc
Limit 1;

-- Country/state have the highest revenue
select country, state, revenue
from bike_sales
where revenue = (select max(revenue) as 'Highest_revenue' from bike_sales);

-- Category/sub-category that generates the most profit
select product_category, sub_category, profit
from bike_sales
where profit = (select max(profit) as 'Most_profit' from bike_sales);

-- Nunber of customer age group by country
select country, age_group, count(age_group) as 'age_group_count'
from bike_sales
group by country, age_group
order by country;

-- How many orders were made in Canada or France?
select country, count(order_quantity) as 'No._of_orders'
from bike_sales
group by country
having country = 'canada' or country = 'france';

-- How many bike racks orders where made from Canada?
select country, sub_category, count(order_quantity) as 'Bike_racks_ordered'
from bike_sales
group by country, sub_category
having country = 'Canada' and sub_category = 'bike racks';

-- Sales in each state of France
select country, state, sum(revenue) as 'Total_sales'
from bike_sales
group by country, State
having country = 'france';

-- How many sales were made per category?
select Product_Category, count(Revenue) as 'No._of_Sales'
from bike_sales
group by Product_Category;

-- Increase the revenue by 10% to every sale made in France
select country, Revenue + (Revenue * 0.1) as 'Revenue_increase'
from bike_sales
where country = 'France';

-- Get the mean revenue of the adults (35-64) sales group
select Age_Group, round(sum(Revenue)/count(revenue), 2) as 'Mean_revenue'
from bike_sales
group by Age_Group
having Age_Group = 'Adults (35-64)';

-- Get all the sales made in the state of Kentucky
select state, sum(Revenue) as 'Total_sales'
from bike_sales
group by state
having state ='Kentucky';

-- Modify all unit_price values adding 3% tax to them
select Unit_Price + (Unit_Price * 0.03) as 'New_unit_price'
from bike_sales;

-- Add and calculate a new calculated_revenue column
select (cost + profit) as 'Calculated_revenue'
from bike_sales;

-- Add and calculate a new calculated_cost column
select (Order_Quantity * Unit_Cost) as 'Calculated_cost'
from bike_sales;

-- How many orders were made in May, June, July of 2016?
select month, year, count(Order_Quantity) as 'Ordered_quantity_count'
from bike_sales
group by Month, year 
having year = 2016 and month in ('may', 'june', 'july');

-- How many orders were made in May 2016?
select month, year, count(Order_Quantity) as 'Order_count'
from bike_sales
group by month, year 
having year = 2016 and month = 'may';

-- What is the mean order_quantity of orders with less than 10k in revenue?
select Revenue, round(sum(Order_Quantity)/count(Order_Quantity), 2) as 'Mean_order_Qty'
from bike_sales
group by Revenue
having Revenue < 10000;

-- What is the mean order_quantity of orders with more than 10k in revenue?
select Revenue, round(sum(Order_Quantity)/count(Order_Quantity), 2) as 'Mean_order_Qty'
from bike_sales
group by Revenue
having Revenue >= 10000;

-- Get the sales with the highest revenue
select Product, Revenue
from bike_sales
order by Revenue desc;

-- Get the top 5 sales with the highest revenue
select Product, Revenue
from bike_sales
order by Revenue desc
limit 5;

-- How many sales with more than 500 in Revenue were made by men?
select Customer_Gender, Revenue, count(Revenue) as Sales_count
from bike_sales
group by Customer_Gender, Revenue
having revenue > 500 and Customer_Gender = 'M';