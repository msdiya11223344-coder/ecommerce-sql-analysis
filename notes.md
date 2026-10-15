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

## Day 4: Medium queries

- Saved 4 medium queries as .sql files (06 to 09) and pushed them to GitHub
- Practiced multiple JOINs, subqueries, CASE WHEN and date functions

### Query 6: Average order value (06_avg_order_value.sql)
- Question: What is the average value of an order?
- Logic: SUM(payment_value) divided by COUNT(DISTINCT order_id), so each order is counted once.
- Insight: Average order value is [avg_order_value] (Brazilian reais).

### Query 7: Revenue by state (07_revenue_by_state.sql)
- Question: Which customer states bring the most revenue?
- Logic: JOIN orders with customers (state is stored in customers) and with payments (revenue is stored in payments). GROUP BY customer_state.
- Why 3 tables: no single table has order, state and payment together.
- Insight: [top state] is the top state with [revenue] revenue from [total_orders] orders.

### Query 8: Repeat customers (08_repeat_customers.sql)
- Question: How many customers ordered more than once?
- Logic: The subquery counts orders per customer. The outer query uses CASE WHEN to count customers with more than 1 order.
- Why customer_unique_id: customer_id changes on every order, so customer_unique_id identifies the real person.
- Insight: [repeat_customers] out of [total_customers] customers ([repeat_pct]%) ordered more than once.

### Query 9: Delivery days by state (09_delivery_days_by_state.sql)
- Question: How many days does delivery take in each state?
- Logic: julianday() converts dates to numbers, so delivery date minus purchase date gives days. AVG per state.
- Why WHERE order_status = 'delivered': orders that are not delivered have an empty delivery date.
- Insight: [slowest state] is the slowest with [avg_delivery_days] days. [fastest state] is the fastest with [avg_delivery_days] days.

### Interview questions I should be able to answer
- INNER JOIN vs LEFT JOIN: INNER JOIN keeps only matching rows. LEFT JOIN keeps all rows from the left table.
- WHERE vs HAVING: WHERE filters rows before grouping. HAVING filters groups after GROUP BY.
- Why a subquery in Query 8: to first get the order count per customer, then count how many have more than 1.