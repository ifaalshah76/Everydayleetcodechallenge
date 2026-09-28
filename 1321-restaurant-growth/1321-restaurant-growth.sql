WITH daily AS
(
    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
cte AS
(
    SELECT
        visited_on,
        SUM(daily_amount) OVER(
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        AVG(daily_amount * 1.0) OVER(
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS average_amount
    FROM daily
)
SELECT
    visited_on,
    amount,
    ROUND(average_amount, 2) AS average_amount
FROM cte
WHERE visited_on >= (
    SELECT DATEADD(DAY, 6, MIN(visited_on))
    FROM Customer
)
ORDER BY visited_on;