-- Question: How many orders and how much revenue overall?
SELECT COUNT(DISTINCT order_id) AS total_orders,
       ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset;