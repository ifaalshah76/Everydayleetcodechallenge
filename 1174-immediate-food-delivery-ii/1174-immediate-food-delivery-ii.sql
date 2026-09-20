WITH first_order AS 
(SELECT customer_id,
MIN(order_date) AS ist
FROM delivery
GROUP BY customer_id)

SELECT 
ROUND(100.0*SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END)/COUNT(*),2) AS immediate_percentage
FROM first_order f
JOIN delivery d 
ON f.customer_id = d.customer_id
AND f.ist = d.order_date