-- Question: How do orders change month by month?
SELECT strftime('%Y-%m', order_purchase_timestamp) AS month,
       COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY month
ORDER BY month;