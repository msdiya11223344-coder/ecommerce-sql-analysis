# E-commerce SQL Analysis (Olist Dataset)

Analyzing Olist e-commerce data using SQL to find revenue drivers, delivery performance, and the impact of delivery time on reviews.

Status: In progress

## Completed so far
- Loaded 9 CSV files into a SQLite database
- Monthly sales trend
- Delivery time and late order analysis
- Review score vs late delivery
- Top sellers and top product categories

## Key finding
On-time orders average 4.29 stars, while late orders average 2.57 stars.

## Planned next
- More charts and visualizations
- Final summary of insights

## Tools
Python, SQLite, pandas, matplotlib, Jupyter Notebook

Dataset: Brazilian E-Commerce Public Dataset by Olist (Kaggle)

## SQL Queries
Saved in the `queries/` folder:

**Basic**
- 01_total_orders_revenue.sql
- 02_orders_by_status.sql
- 03_top_categories.sql
- 04_monthly_orders.sql
- 05_payment_type_split.sql

**Medium (JOINs, subqueries, date functions)**
- 06_avg_order_value.sql
- 07_revenue_by_state.sql
- 08_repeat_customers.sql
- 09_delivery_days_by_state.sql

**Advanced (CTEs and window functions)**
- 10_monthly_revenue_growth.sql
- 11_running_total_revenue.sql
- 12_top_customers_rank.sql
- 13_top_product_per_category.sql