WITH firstlog AS
(SELECT 
player_id,
MIN(event_date) AS first_login
FROM activity
GROUP BY player_id)

SELECT
    ROUND(
        1.0 * COUNT(DISTINCT f.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM firstlog f
JOIN Activity a
    ON f.player_id = a.player_id
   AND a.event_date = DATEADD(day, 1, f.first_login)
;