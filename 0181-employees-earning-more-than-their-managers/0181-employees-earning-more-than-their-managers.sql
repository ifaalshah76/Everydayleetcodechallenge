/* Write your T-SQL query statement below */
SELECT e.name AS Employee
FROM employee e
JOIN employee m 
ON e.managerId = m.id
WHERE e.salary > m.salary;