WITH cte AS
(
    SELECT
        id,
        visit_date,
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),
cte2 AS
(
    SELECT
        *,
        COUNT(*) OVER (PARTITION BY grp) AS consecutive_count
    FROM cte
)
SELECT
    id,
    visit_date,
    people
FROM cte2
WHERE consecutive_count >= 3
ORDER BY visit_date;