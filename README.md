# E-commerce Sales Analysis Project

## Project Overview
An e-commerce sales analysis project using MySQL and Microsoft Power BI to explore transaction data and identify business insights.

## SQL Analysis — MySQL
### Basic Analysis
- Analyzed e-commerce transaction data using SQL queries.
- Used filtering, aggregation, grouping, and sorting to answer business questions.

### Advanced Analysis
- Performed advanced business analysis using SQL.
- Analyzed customer purchases, monthly sales, and order patterns through SQL queries.

## Power BI Dashboard
Created an interactive dashboard featuring:
- Total Sales
- Total Orders
- Total Customers
- Total Quantity
- Monthly Sales Trend (Dec 2010–Dec 2011)
- Top 10 Products by Sales
- Sales by Country
- Year and Country slicers

## Dashboard Preview
![E-commerce Sales Analysis Dashboard](e-commerce%20sales%20analysis%20dashboard.png)

## Tools and Technologies
- MySQL
- SQL
- Microsoft Power BI
- DAX
- Data Analysis and Visualization

## Project Files
- `01_Ecommerce_Sales_Analysis.sql` — Basic SQL analysis
- `02_E-commerce_sales_analysis.sql` — Advanced SQL analysis
- `E-Commerce_Sales_Analysis.pbix` — Power BI dashboard
- `e-commerce sales analysis dashboard.png` — Dashboard screenshot

## Objective
To practice SQL-based business analysis and communicate sales insights through an interactive Power BI dashboard.

## Business Insights & Recommendations

- **Monthly Sales Trend:** November 2011 recorded the highest monthly sales in the dataset. December 2011 covers data only through December 9, so it should not be directly compared with complete months.

- **Country-wise Sales:** The United Kingdom generated the highest sales among the countries in the dataset. The business can monitor demand and product availability in this market while exploring growth opportunities in other countries.

- **Top 10 Products:** After excluding postage-related entries, Regency Cakestand 3 Tier ranked highest by sales among the products shown in the updated chart. The business should monitor demand for high-revenue products and review stock levels.

- **Cancellation Analysis:** Cancellation-related invoice rows contributed approximately -£893.98K in calculated sales value. This value requires validation before being interpreted as refunds or financial losses.
## Data Quality Limitations

- **Cancelled Invoices:** The Total Orders KPI counts distinct invoice numbers, including cancellation-related invoices. Therefore, it should not be interpreted as the exact number of completed orders.

- **Negative Quantities:** The dataset contains approximately 11,000 transaction rows with negative quantities. These may represent returns or adjustments and require further investigation.

- **Missing Customer IDs:** The Total Customers measure excludes blank CustomerIDs, so it represents identified customers rather than every possible customer.

- **Incomplete December Data:** December 2011 contains data only through December 9. Therefore, its sales should not be directly compared with complete months.

- **Postage Items:** Postage-related entries have been excluded from the Top 10 merchandise chart. However, they remain included in the overall Total Sales calculation.

## Business Recommendations

- Monitor cancellation-related invoices separately from total invoices.
- Investigate negative quantities to understand returns and transaction adjustments.
- Maintain sufficient stock of high-revenue products based on demand analysis.
- Compare sales over equivalent time periods and investigate monthly trends.
- Explore opportunities to improve sales in countries beyond the United Kingdom.
