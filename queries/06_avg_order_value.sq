-- Question: What is the average value of an order?
SELECT ROUND(SUM(payment_value) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM olist_order_payments_dataset;