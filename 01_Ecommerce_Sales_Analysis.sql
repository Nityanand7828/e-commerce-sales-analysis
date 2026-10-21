-- ============================================
-- PROJECT: E-COMMERCE SALES ANALYSIS
-- Database: MySQL
-- Dataset: Online Retail
-- Purpose: Analyze sales, customers, products,
-- countries, invoices, and monthly sales trends.
-- ============================================


create database ecommerce_sales;
use ecommerce_sales;


-- SECTION 1: DATA OVERVIEW
-- --------------------------------------------
select*
from ecommerce_sales.online_retail
limit 10;

-- TASK 1: CALCULATE TOTAL SALES VALUE
-- --------------------------------------------
select 
sum(Quantity * UnitPrice) as total_sales_revenue
from ecommerce_sales.online_retail;



-- TASK 2: COUNT UNIQUE INVOICES
select 
count(distinct invoiceNo) as unique_invoice
from ecommerce_sales.online_retail;



-- TASK 3: TOP 10 COUNTRIES BY SALES VALUE
-- --------------------------------------------
select country,
sum(quantity * unitprice) as highest_sales_revenue
from ecommerce_sales.online_retail
group by Country
order by highest_sales_revenue desc
limit 10;



-- TASK 4: MONTHLY SALES TREND
-- --------------------------------------------
select date_format(invoicedate, '%Y-%m')as month_wise,
	   sum(quantity*unitprice)as total_revenue
from ecommerce_sales.online_retail
group by date_format(invoicedate,'%Y-%m')
order by month_wise asc;



-- TASK 5: TOP 10 PRODUCTS BY QUANTITY SOLD
-- --------------------------------------------
select description as product_name,
      sum(quantity) as total_quantity
from ecommerce_sales.online_retail
group by description
order by total_quantity desc
limit 10;


-- TASK 6: TOP 10 CUSTOMERS BY TOTAL SPENDING
-- --------------------------------------------
select customerid as customer_name,
      sum(quantity*unitprice) as total_spent
from ecommerce_sales.online_retail
where CustomerID is not null
group by customerid
order by total_spent desc
limit 10;



-- TASK 7: TOP 10 CUSTOMERS BY NUMBER OF UNIQUE INVOICES
-- ----------------------------------------------------
select customerid as customer_id,
       count(distinct invoiceNo ) as unique_invoices
from ecommerce_sales.online_retail
where CustomerID is not null
group by CustomerID
order by unique_invoices desc
limit 10; 



-- TASK 8: COUNT TRANSACTIONS WITH NEGATIVE QUANTITY
-- ------------------------------------------------
select count(*) as negative_quantity
from ecommerce_sales.online_retail
where quantity < 0; 



-- TASK 9: CLASSIFY RECORDS BY QUANTITY TYPE
-- -----------------------------------------
select 
  case 
    when quantity > 0 then 'positive'
    when quantity < 0 then 'negative'
    when quantity = 0 then 'zero'
end as quantity_records,
count(*) as total_records
from ecommerce_sales.online_retail
group by quantity_records;



-- TASK 10: COUNT INVOICES STARTING WITH 'C'
-- -----------------------------------------
select count(*) as invoice_records
from ecommerce_sales.online_retail
where InvoiceNo like 'c%'; 



-- TASK 11: TOP 10 PRODUCTS BY HIGHEST UNIT PRICE
-- ----------------------------------------------
select description as product_name, 
       max(unitprice) as highest_unit_price
from ecommerce_sales.online_retail
group by description
order by highest_unit_price desc
limit 10;



-- TASK 12: TOP 10 PRODUCTS BY AVERAGE UNIT PRICE
-- ----------------------------------------------
select description as product_name,
     avg(unitprice) as avg_unit_price
from ecommerce_sales.online_retail
group by description
order by avg_unit_price desc
limit 10;



-- TASK 13: TOP 10 PRODUCTS BY TOTAL SALES VALUE
-- ---------------------------------------------
select description as product_name,
     sum(quantity * unitprice) as total_revenue
from ecommerce_sales.online_retail
group by Description
order by total_revenue desc
limit 10; 



-- TASK 14: COMPARE TOTAL POSITIVE AND NEGATIVE QUANTITIES
-- -------------------------------------------------------
select 
   case 
      when quantity > 0 then 'positive'
      when quantity < 0 then 'negative'
      end as quantity_records,
	sum(quantity) as total_quantity
from ecommerce_sales.online_retail
where Quantity <> 0
group by quantity_records;



-- TASK 15: FIND INVOICES WITH MORE THAN 5 RECORDS
-- ------------------------------------------------
select invoiceno as invoice_no,
count(*) as product_count
from ecommerce_sales.online_retail
group by InvoiceNo
having product_count > 5; 



-- TASK 16: FIND CUSTOMERS WITH TOTAL SPENDING ABOVE 10000
-- -------------------------------------------------------
select customerid as customer_id,
sum(quantity * unitprice) as total_spent
from ecommerce_sales.online_retail
where Customerid is not null
group by Customerid
having total_spent > 10000;
 
 
 
 -- TASK 17: FIND CUSTOMERS WITH MORE THAN 10 UNIQUE INVOICES
-- --------------------------------------------------------
select customerid as customer_id,
     count( distinct invoiceno) as unique_invoice
from ecommerce_sales.online_retail
where CustomerID is not null
group by Customerid
having unique_invoice > 10;



-- TASK 18: DAILY SALES VALUE ANALYSIS
-- -----------------------------------
select date(invoicedate) as invoice_date,
     sum(quantity * unitprice) as total_revenue
from ecommerce_sales.online_retail
group by date(invoicedate)
order by invoice_date asc;



-- TASK 19: IDENTIFY THE DAY WITH THE HIGHEST SALES VALUE
-- ------------------------------------------------------
select date(invoicedate) as highest_date,
  sum(quantity * unitprice) as highest_total_revenue
from ecommerce_sales.online_retail
group by date(invoicedate)
order by highest_total_revenue desc
limit 1;



-- TASK 20: MONTHLY UNIQUE INVOICE COUNT
-- -------------------------------------
select date_format(invoicedate,'%Y-%m') as month_wise,
count(distinct invoiceno) as unique_invoice_no
from ecommerce_sales.online_retail
group by date_format(invoicedate,'%Y-%m')
order by month_wise asc;



-- TASK 21: FIND THE MONTH WITH THE HIGHEST NUMBER OF UNIQUE INVOICES
-- ------------------------------------------------------------------
select date_format(invoicedate, '%Y-%m') as month,
       count(distinct invoiceno) as unique_invoice
from ecommerce_sales.online_retail
group by date_format(invoicedate, '%Y-%m')
order by unique_invoice desc
limit 1; 



-- TASK 22: TOP 5 COUNTRIES BY UNIQUE INVOICE COUNT
-- ------------------------------------------------
select country as country_name,
count(distinct invoiceno ) as unique_invoice
from ecommerce_sales.online_retail
group by country
order by unique_invoice desc
limit 5;


-- TASK 23: TOP 5 COUNTRIES BY TOTAL QUANTITY
-- ------------------------------------------
select country as country_name,
  sum(quantity) as total_quantity
from ecommerce_sales.online_retail
group by country
order by total_quantity desc
limit 5;


-- TASK 24: TOP 5 COUNTRIES BY AVERAGE UNIT PRICE
-- ----------------------------------------------
select country as country_name,
      avg(unitprice) as avg_unitprice
from ecommerce_sales.online_retail
group by country
order by avg_unitprice desc
limit 5;


-- TASK 25: TOP 10 COUNTRIES BY RECORD COUNT
-- ----------------------------------------
SELECT
    Country,
    COUNT(*) AS total_records
FROM ecommerce_sales.online_retail
GROUP BY Country
ORDER BY total_records DESC
LIMIT 10;


