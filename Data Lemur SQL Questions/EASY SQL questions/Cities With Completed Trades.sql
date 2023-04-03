-- You are given the tables below containing information on Robinhood trades and users. 
-- Write a query to list the top three cities that have the most completed trade orders in descending order.

-- Output the city and number of orders.


                     -- trades Example Table: --
| order_id | user_id | price | quantity |   status  |      timestamp      |
|:--------:|:-------:|:-----:|:--------:|:---------:|:-------------------:|
|  100101  |   111   |  9.80 |    10    | Cancelled | 08/17/2022 12:00:00 |
|  100102  |   111   | 10.00 |    10    | Completed | 08/17/2022 12:00:00 |
|  100259  |   148   |  5.10 |    35    | Completed | 08/25/2022 12:00:00 |


-- Solution: --
SELECT city, COUNT(order_id) AS total_orders FROM trades
FULL OUTER JOIN users
ON trades.user_id = users.user_id
WHERE status = 'Completed'
GROUP BY city
ORDER BY total_orders DESC
LIMIT 3


          -- Output --
|      city     | total_orders |
|:-------------:|:------------:|
| San Francisco |       4      |
|     Boston    |       3      |
|     Denver    |       2      |
