WITH firstlog AS
(SELECT *,
ROW_NUMBER()OVER(PARTITION BY player_id ORDER BY event_date ) AS Rnk
FROm activity)

SELECT
    ROUND(
        1.0 * COUNT(DISTINCT a.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM firstlog f
JOIN Activity a
    ON f.player_id = a.player_id
   AND a.event_date = DATEADD(day, 1, f.event_date)
WHERE f.Rnk = 1;