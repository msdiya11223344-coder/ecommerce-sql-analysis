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
- Insight: Average order value is 160.99 (Brazilian reais).

### Query 7: Revenue by state (07_revenue_by_state.sql)
- Question: Which customer states bring the most revenue?
- Logic: JOIN orders with customers (state is stored in customers) and with payments (revenue is stored in payments). GROUP BY customer_state.
- Why 3 tables: no single table has order, state and payment together.
- Insight:  SP is the top state with 5,998,226.96 revenue from 41,745 orders, about 37% of total revenue. RJ (2,144,379.69) and MG (1,872,257.26) follow.

### Query 8: Repeat customers (08_repeat_customers.sql)
- Question: How many customers ordered more than once?
- Logic: The subquery counts orders per customer. The outer query uses CASE WHEN to count customers with more than 1 order.
- Why customer_unique_id: customer_id changes on every order, so customer_unique_id identifies the real person.
- Insight: - Insight: Only 2,997 out of 96,096 customers (3.12%) ordered more than once, so customer retention is weak.

### Query 9: Delivery days by state (09_delivery_days_by_state.sql)
- Question: How many days does delivery take in each state?
- Logic: julianday() converts dates to numbers, so delivery date minus purchase date gives days. AVG per state.
- Why WHERE order_status = 'delivered': orders that are not delivered have an empty delivery date.
- Insight:  RR is the slowest with 29.4 days, then AP (27.2) and AM (26.4). SP is the fastest with 8.8 days.

### Interview questions I should be able to answer
- INNER JOIN vs LEFT JOIN: INNER JOIN keeps only matching rows. LEFT JOIN keeps all rows from the left table.
- WHERE vs HAVING: WHERE filters rows before grouping. HAVING filters groups after GROUP BY.
- Why a subquery in Query 8: to first get the order count per customer, then count how many have more than 1.


## Day 5: Window functions and CTE

- Saved 4 window function queries (10 to 13) and pushed them to GitHub
- Learned LAG, running total with SUM OVER, RANK, ROW_NUMBER, PARTITION BY and CTE

### Query 10: Monthly revenue growth (10_monthly_revenue_growth.sql)
- Question: How does revenue change month over month?
- Logic:  A CTE calculates monthly revenue. LAG(revenue) gives the previous month, so growth % = (current minus previous) / previous.
- Insight: November 2017 was the peak month with 1,194,882.80 revenue, up 53.25% from October. December 2017 then dropped 26.49%.
- Note: Growth in early months (like +705,751% in January 2017) is misleading because the previous month had only 19.62 revenue. The last months (Sep and Oct 2018) look like big drops because the dataset ends there with incomplete data.

### Query 11: Running total revenue (11_running_total_revenue.sql)
- Question: How does total revenue build up over time?
- Logic: SUM(revenue) OVER (ORDER BY month) adds each month to all earlier months.
- Insight: The running total reaches 16,008,872.12 in October 2018, which matches the total revenue from Query 1.

### Query 12: Top customers (12_top_customers_rank.sql)
- Question: Who are the top 10 customers by spending?
- Logic: RANK() OVER (ORDER BY SUM(payment_value) DESC) ranks customers by total spending.
- Insight: The top customer spent 13,664.08 in a single order. The second spent 9,553.02 across 3 orders.

### Query 13: Top product per category (13_top_product_per_category.sql)
- Question: Which product earns the most in each category?
- Logic: ROW_NUMBER() with PARTITION BY category restarts the ranking inside each category. WHERE rn = 1 keeps the best product.
- Insight:  The best product is in health_beauty with 63,885.00 revenue, followed by computers (48,899.34) and computers_accessories (47,214.51).

### Interview questions I should be able to answer
- GROUP BY vs window function: GROUP BY collapses rows, a window function keeps every row.
- RANK vs ROW_NUMBER: RANK gives the same rank to ties and skips numbers, ROW_NUMBER gives every row a unique number.
- What is a CTE: a named temporary result that makes a long query easier to read.
- What does PARTITION BY do: it splits rows into groups and restarts the calculation in each group.