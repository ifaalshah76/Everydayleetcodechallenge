/* Write your T-SQL query statement below */

WITH cte as
(SELECT 
d.name AS department, 
e.name AS Employee , 
e.Salary AS salary,
DENSE_RANK()OVER(PARTITION BY d.name ORDER BY e.salary DESC) rnk
FROM employee e
JOIN department d 
ON e.departmentId = d.id) 

SELECT 
Department,
Employee,
Salary
FROM cte
where rnk <=3