WITH cte AS
(
    SELECT 
        num,
        LEAD(num) OVER(ORDER BY id) AS nxt,
        LAG(num) OVER(ORDER BY id) AS prev
    FROM Logs
)
SELECT DISTINCT
    num AS ConsecutiveNums
FROM cte
WHERE num = nxt
  AND num = prev;