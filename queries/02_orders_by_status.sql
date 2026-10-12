-- Question: What share of orders is in each status?
SELECT order_status,
       COUNT(*) AS total_orders,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), 2) AS pct
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;