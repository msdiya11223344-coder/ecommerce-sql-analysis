-- Question: Which product earns the most revenue in each category?
WITH product_rev AS (
    SELECT COALESCE(t.product_category_name_english, p.product_category_name) AS category,
           oi.product_id,
           ROUND(SUM(oi.price), 2) AS revenue
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t
           ON p.product_category_name = t.product_category_name
    GROUP BY category, oi.product_id
),
ranked AS (
    SELECT category, product_id, revenue,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
    FROM product_rev
)
SELECT category, product_id, revenue
FROM ranked
WHERE rn = 1
ORDER BY revenue DESC
LIMIT 10;
