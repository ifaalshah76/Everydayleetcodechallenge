WITH prevs AS 
(SELECT 
id,
recordDate,
temperature,
LAG(recordDate)OVER(ORDER BY recordDate) Prev,
LAG(temperature) OVER(ORDER BY recordDate) AS PrevTemp
FROM weather)

SELECT id
FROM prevs
WHERE DATEDIFF(day, Prev, recordDate) = 1
AND temperature > PrevTemp
