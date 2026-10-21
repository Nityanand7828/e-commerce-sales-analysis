USE ecommerce_sales;

-- ============================================
-- SECTION 2: ADVANCED E-COMMERCE ANALYSIS
-- =========================================


-- TASK 1: TOP 10 CUSTOMERS BY TOTAL SALES
select customerid,
sum(quantity * unitprice ) as total_sales
from ecommerce_sales.online_retail
where customerid is not null
and invoiceno not like 'c%'
group by CustomerID
order by total_sales desc
limit 10;


-- TASK 2: MONTHLY SALES TREND
-- Objective: Analyze total sales month by month in chronological order.
select 
   sum(quantity * unitprice) as total_sales,
   date_format(invoicedate, '%Y-%m') as sales_month
from ecommerce_sales.online_retail
group by sales_month
order by sales_month asc;


-- TASK 3: TOP-SELLING PRODUCTS
-- Objective: Identify products generating the highest total sales.
select 
    description as product_name,
	StockCode,
    sum(quantity * unitprice) as total_sales
from ecommerce_sales.online_retail
where invoiceno not like 'c%'
group by StockCode,Description
order by total_sales desc
limit 10;


-- TASK 4: COUNTRY-WISE SALES ANALYSIS
-- Objective: Calculate total sales for each country.
select  
    country,
    sum(quantity * unitprice) as total_sales
from ecommerce_sales.online_retail
group by country
order by total_sales desc;


-- TASK 5: TOP COUNTRIES BY NUMBER OF ORDERS
-- Objective: Identify countries with the highest number of unique orders.

select 
    country,
    count(distinct invoiceno ) as total_orders
from ecommerce_sales.online_retail
group by country
order by total_orders desc
limit 10;


-- TASK 6: AVERAGE ORDER VALUE BY COUNTRY
-- Objective: Calculate the average value of an order for each country.

with invoice_total as (
select 
    country,
    sum(quantity * unitprice ) as invoice_total_value
from ecommerce_sales.online_retail
group by country,invoiceno
)
select invoice_total.country,
       avg(invoice_total.invoice_total_value) as avg_order_value
from invoice_total
group by invoice_total.country
order by avg_order_value desc;
   
  
-- TASK 7: REPEAT CUSTOMERS ANALYSIS
-- Objective: Identify customers who placed more than one order.

select 
    customerid,
    count(distinct invoiceno ) as total_order
from ecommerce_sales.online_retail
where CustomerID is not null
group by customerid
having total_order > 1
order by total_order desc;


-- TASK 8: CUSTOMER-WISE TOTAL SPENDING
-- Objective: Calculate total spending for each customer.

select 
    customerid,
    sum(quantity * unitprice) as total_spent
from ecommerce_sales.online_retail
where CustomerID is not null
group by customerid
having total_spent > 5000
order by total_spent desc;


-- TASK 9: MONTHLY ORDER COUNT
-- Objective: Calculate the number of unique orders placed each month.

select
 date_format(invoicedate,'%Y-%m') as sales_month,
count(distinct invoiceno ) as total_orders
from ecommerce_sales.online_retail
group by sales_month
order by sales_month asc;



-- TASK 10: MONTHLY REVENUE ANALYSIS
-- Objective: Calculate total revenue for each month.

select 
    date_format(invoicedate,'%Y-%m') as sales_month,
    sum(quantity * unitprice ) as total_order
from ecommerce_sales.online_retail
group by sales_month
order by sales_month asc;


-- TASK 11: TOP 10 CUSTOMERS BY NUMBER OF ORDERS
-- Objective: Identify customers who placed the most orders.

select customerid,
count(distinct invoiceno) as unique_order
from ecommerce_sales.online_retail
where customerid is not null
group by customerid
order by unique_order desc
limit 10;


-- TASK 12: TOP 10 PRODUCTS BY QUANTITY SOLD
-- Objective: Identify the products sold in the largest quantities.
select stockcode,
       description as product_name,
       sum(quantity) as total_quantity
from ecommerce_sales.online_retail
group by stockcode,product_name
order by total_quantity desc
limit 10;



-- TASK 13: PRODUCTS WITH NEGATIVE TOTAL QUANTITY
-- Objective: Identify products with a negative net quantity.
select stockcode,
       description as product_name,
       sum(quantity) as net_quantity
from ecommerce_sales.online_retail
group by stockcode,product_name
having net_quantity < 0 
order by net_quantity asc;



-- TASK 14: COUNTRY-WISE UNIQUE CUSTOMER COUNT
-- Objective: Find how many unique customers belong to each country.

select country,
      count(distinct customerid) as unique_customers
from ecommerce_sales.online_retail
where CustomerID is not null
group by country
order by unique_customers desc;


-- TASK 15: COUNTRY-WISE AVERAGE SALES PER INVOICE
-- Objective: Calculate the average invoice value for each country.

with total_invoice as ( 
select country,
    sum(quantity * unitprice ) as total_value
from ecommerce_sales.online_retail
group by country,invoiceno
)
select total_invoice.country,
       avg(total_invoice.total_value) as avg_value_order
from total_invoice
group by total_invoice.country
order by avg_value_order desc;


-- TASK 16: MONTHLY REVENUE GROWTH
-- Objective: Compare each month's revenue with the previous month.

with monthly_revenue as ( 
 select
     date_format(invoicedate,'%Y-%m') as sales_month,
     sum(quantity * unitprice ) as total_revenue
from ecommerce_sales.online_retail
group by sales_month
)
select monthly_revenue.sales_month,
       monthly_revenue.total_revenue,
	lag(monthly_revenue.total_revenue)
    over (order by sales_month asc) as previous_month_revenue
from monthly_revenue;



-- TASK 17: CUSTOMER PURCHASE FREQUENCY
-- Objective: Count the distinct months in which each customer made purchases.

select
    customerid,
    count(distinct date_format(invoicedate,'%Y-%m') ) as distinct_month
from ecommerce_sales.online_retail
where customerid is not null
group by customerid
having distinct_month >= 2
order by distinct_month desc;


-- TASK 18: PRODUCT RETURN ANALYSIS
-- Objective: Identify products with the highest returned quantities.

select 
      stockcode,
      description as product_name,
      sum(quantity) as total_returned
from ecommerce_sales.online_retail
where Quantity < 0
group by stockcode,product_name
order by total_returned asc
limit 10;


-- TASK 19: COUNTRY-WISE REVENUE CONTRIBUTION
-- Objective: Calculate each country's percentage contribution to total revenue.

with country_revenue as (
select country,
     sum(quantity * unitprice ) as revenue
from ecommerce_sales.online_retail
group by country
),
 total_revenue as (
 select  sum(revenue) as total_revenue
from country_revenue
)
select country_revenue.country,
       country_revenue.revenue,
       total_revenue.total_revenue,
	  (country_revenue.revenue/total_revenue.total_revenue * 100) as revenue_percentage
from country_revenue
cross join total_revenue
order by revenue_percentage desc;


-- TASK 20: DAILY SALES ANALYSIS
-- Objective: Calculate total sales revenue for each day.

select 
    date(invoicedate) as sales_date,
    sum(quantity *unitprice) as daily_revenue
from ecommerce_sales.online_retail
group by sales_date
order by daily_revenue desc
limit 10;



-- TASK 21: CUSTOMER SALES SEGMENTATION
-- Objective: Classify customers based on their total spending

with total_spending as (
select customerid,
       sum(quantity * unitprice) as total_spends
from ecommerce_sales.online_retail
where CustomerID is not null
group by customerid
)
select total_spending.customerid,
       total_spending.total_spends,
       case 
          when total_spends >= 10000
            then 'Higher spender'
          when total_spends >= 5000
			then 'Medium spender'
		  when total_spends < 5000
             then 'lower spender'
		end as customer_sagement
from total_spending
order by total_spends desc;


-- TASK 22: CUSTOMER ORDER RANKING
-- Objective: Rank customers based on their total number of orders.

with total_orders as (
select customerid,
     count(distinct invoiceno) as total_order
from ecommerce_sales.online_retail
where CustomerID is not null 
group by customerid
)
select 
  total_orders.customerid,
  total_orders.total_order,
  dense_rank() over(order by total_order desc) 
  as customer_rank
  from total_orders;
     
-- TASK 23: MONTH-OVER-MONTH REVENUE CHANGE
-- Objective: Calculate the revenue difference between consecutive months.

with monthly_revenue as (
select 
    date_format(invoicedate,'%Y-%m') as sales_month,
    sum(quantity * UnitPrice) as total_revenue
from ecommerce_sales.online_retail
group by sales_month
)
  select monthly_revenue.sales_month,
         monthly_revenue.total_revenue,
         monthly_revenue.total_revenue - 
         lag(total_revenue) over(order by sales_month asc)as revenue_change
  from monthly_revenue;
         
         
-- TASK 24: CUSTOMER REVENUE RANKING
-- Objective: Rank customers based on their total spending.

with high_spend as (
select  
    customerid,
    sum(quantity * unitprice) as total_spending
from ecommerce_sales.online_retail
where CustomerID is not null 
group by CustomerID
)

select 
     high_spend.customerid,
     high_spend.total_spending,
     dense_rank() over(order by high_spend.total_spending desc)
     as customer_rank
from high_spend
order by customer_rank asc
limit 10;
     

-- TASK 25: MONTHLY TOP 3 PRODUCTS BY REVENUE
-- Objective: Identify the top 3 products by revenue for each month.

with monthly_revenue as (
 select 
       stockcode,
       description as product_name,
       date_format(invoicedate,'%Y-%m') as sales_month,
       sum(quantity * unitprice) as total_revenue
from ecommerce_sales.online_retail
group by StockCode,product_name,sales_month
),
  rank_product as (
select 
       monthly_revenue.sales_month,
       monthly_revenue.stockcode,
       monthly_revenue.product_name,
       monthly_revenue.total_revenue,
       dense_rank() over ( partition  by monthly_revenue.sales_month 
       order by monthly_revenue.total_revenue desc) as product_rank
from monthly_revenue
)
select rank_product.sales_month,
       rank_product.stockcode,
       rank_product.product_name,
       rank_product.total_revenue,
       rank_product.product_rank
from rank_product
where product_rank <= 3;


	