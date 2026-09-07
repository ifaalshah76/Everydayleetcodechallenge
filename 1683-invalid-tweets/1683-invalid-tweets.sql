/* Write your T-SQL query statement below */
SELECT tweet_id 
FROM tweets 
WHERE Len(content) > 15