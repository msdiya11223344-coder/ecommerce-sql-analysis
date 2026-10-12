# Project Notes

## Day 1
- Downloaded Olist dataset (9 CSV files)
- Set up project folders and GitHub repo

## Day 2
- Loaded 9 CSV files into a SQLite database (ecommerce.db)
- Monthly sales trend, peak in November 2017
- Delivery time and late order analysis
- Review score vs late delivery: on time 4.29, late 2.57
- Top sellers and top product categories
- Made a monthly revenue chart
- Committed the project with Git and pushed it to GitHub


## Day 3
- Saved 5 easy queries as .sql files in the queries folder and pushed them to GitHub
- Fixed an empty database problem by using the full path to the real ecommerce.db

### Query 1: Total orders and revenue (01_total_orders_revenue.sql)
- Question: How many orders and how much revenue overall?
- Logic: COUNT(DISTINCT order_id) so each order counts once, SUM(payment_value) for revenue.
- Insight: (99440) orders and (16008872.12) total revenue.


### Query 2: Orders by status (02_orders_by_status.sql)
- Question: What share of orders is in each status?
- Logic: GROUP BY order_status. Percentage = COUNT(*) * 100.0 divided by total orders from a subquery.
- Insight: (97.02)% of orders are delivered.

### Query 3: Top 10 categories (03_top_categories.sql)
- Question: Which product categories bring the most revenue?
- Logic: JOIN order_items with products, LEFT JOIN the translation table for English names, SUM(price), GROUP BY category, ORDER BY DESC, LIMIT 10.
- Why LEFT JOIN: it keeps products that have no translated category instead of dropping them.
- Insight: (health_beauty) is the top category by revenue. By items sold, bed_bath_table, health_beauty and sports_leisure lead.

### Query 4: Monthly orders (04_monthly_orders.sql)
- Question: How do orders change month by month?
- Logic: strftime('%Y-%m', order_purchase_timestamp) extracts the month, then GROUP BY month.
- Insight: Orders peaked in November 2017 with (7269) orders.

### Query 5: Payment type split (05_payment_type_split.sql)
- Question: Which payment types bring the most revenue?
- Logic: GROUP BY payment_type with COUNT of payments and SUM of payment_value.
- Insight: (credit_card) is the most used payment type with (78.34)% of revenue.

### Problem I faced
- Jupyter created an empty ecommerce.db because of a relative path. Fix: use the full path to the real database (111.7 MB).