-- Question: Who are the top 10 customers by total spending?
SELECT c.customer_unique_id,
       COUNT(DISTINCT o.order_id) AS orders,
       ROUND(SUM(p.payment_value), 2) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.payment_value) DESC) AS spend_rank
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY spend_rank
LIMIT 10;
