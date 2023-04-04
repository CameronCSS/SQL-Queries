-- Data in Motion SQL Challenge week #33

-- QUESTION 1:

-- The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

-- Write an SQL query to find the confirmation rate of each user.

-- Return the result table in any order.


        Signups table:                          Confirmations table:
| user_id |      time_stamp     |   | user_id |      time_stamp     |   action  |
|:-------:|:-------------------:|   |:-------:|:-------------------:|:---------:|
|    3    | 2020-03-21 10:16:13 |   |    3    | 2021-01-06 03:30:46 |  timeout  |
|    7    | 2020-01-04 13:57:59 |   |    3    | 2021-07-14 14:00:00 |  timeout  |
|    2    | 2020-07-29 23:09:44 |   |    7    | 2021-06-12 11:57:29 | confirmed |
|    6    | 2020-12-09 10:39:37 |   |    7    | 2021-06-13 12:58:28 | confirmed |
|         |                     |   |    7    | 2021-06-14 13:59:27 | confirmed |
|         |                     |   |    2    | 2021-01-22 00:00:00 | confirmed |
|         |                     |   |    2    | 2021-02-28 23:59:59 |  timeout  |



   "Solution:"
WITH counts AS (
    SELECT s.user_id,
        COUNT(action) AS actions,
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed
    FROM Confirmations c
    RIGHT JOIN Signups s ON s.user_id = c.user_id
    GROUP BY user_id
)

SELECT user_id, COALESCE(ROUND((confirmed / actions),2),0) AS confirmation_rate
    FROM counts
    GROUP BY user_id
    
    

       -- OUTPUT --            
| user_id | confirmation_rate |
| ------- | ----------------- |
| 3       | 0                 |
| 7       | 1                 |
| 2       | 0.5               |
| 6       | 0                 |


--------------------------------------

-- QUESTION 2:

-- Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table.

-- Return the resulting table in any order.
-- The query result format is in the following example.


                 -- Sales table: --                          -- Product table: --
| sale_id | product_id | year | quantity | price |       | product_id | product_name |
|:-------:|:----------:|:----:|:--------:|:-----:|       |:----------:|:------------:|
|    1    |     100    | 2008 |    10    |  5000 |       |     100    |     Nokia    |
|    2    |     100    | 2009 |    12    |  5000 |       |     200    |     Apple    |
|    7    |     200    | 2011 |    15    |  9000 |       |     300    |    Samsung   |


-- Soultion: --
SELECT product_name, year, price
FROM Sales s
JOIN Product p ON s.product_id = p.product_id

         -- Output: -- 
| product_name | year | price |
| ------------ | ---- | ----- |
| Nokia        | 2009 | 5000  |
| Nokia        | 2008 | 5000  |
| Apple        | 2011 | 9000  |
