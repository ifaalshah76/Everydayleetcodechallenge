---WITH cte as 
---(SELECT
--customer_id,
--MIN(order_date) AS first_order 
--FROM delivery
--GROUP BY customer_id)

-- SELECT 
-- ROUND(100.0* SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END)/COUNT(*),2) AS immediate_percentage
-- FROM delivery d 
-- JOIN cte f
-- ON d.customer_id = f.customer_id
-- AND d.order_date = f.first_order

WITH cte as 
(SELECT
*,
ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date) rnk
FROM delivery)

SELECT ROUND(100.0* SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)/COUNT(*),2) AS immediate_percentage
FROM cte
WHERE rnk = 1
