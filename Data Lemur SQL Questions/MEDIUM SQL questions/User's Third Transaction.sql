-- Assume you are given the table below on Uber transactions made by users. 
-- Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

-- transactions Example Table: --
| user_id | spend  | transaction_date    |
|---------|--------|---------------------|
| 111     | 100.50 | 01/08/2022 12:00:00 |
| 111     | 55.00  | 01/10/2022 12:00:00 |
| 121     | 36.00  | 01/18/2022 12:00:00 |


--  OLD SOLUTION from 1 Year Ago --
-- OLD Solution: --
WITH trans_x AS (
SELECT user_id, MAX(transaction_date) AS transaction_date, COUNT(transaction_date) AS transactions
FROM transactions
GROUP BY user_id HAVING COUNT(transaction_date) >= 3
)

SELECT t1.user_id AS user_id, spend, t1.transaction_date AS transaction_date
FROM trans_x t2
JOIN transactions t1
ON t1.transaction_date = t2.transaction_date

-- OUTPUT --
| user_id | spend  | transaction_date    |
|---------|--------|---------------------|
| 111     | 89.60  | 02/05/2022 12:00:00 |
| 121     | 67.90  | 04/03/2022 12:00:00 |
| 263     | 100.00 | 07/12/2022 12:00:00 |


NEW -- NEW SOLUTION !! --
-- The problem with the old solution was it was overly complex for no real reason. 
-- It assumed you had to verify someone had at least 3 transactions and then find the 3rd.

-- NEW SOLUTION !! --
-- We could do this with a subquery instead of a CTE. But I pretty much always prefer to use a CTE --

WITH dates AS (
SELECT 
  user_id,
  spend,
  transaction_date,
  ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS row
FROM 
  transactions
)

SELECT
  user_id,
  spend,
  transaction_date
FROM
  dates
WHERE
  row = 3


-- NOTES--
-- WE could order by user id to clean things up, but if you dont HAVE to do it, then dont. you save resources and query time.
  
-- OUTPUT --
| user_id | spend  | transaction_date    |
|---------|--------|---------------------|
| 111     | 89.60  | 02/05/2022 12:00:00 |
| 121     | 67.90  | 04/03/2022 12:00:00 |
| 263     | 100.00 | 07/12/2022 12:00:00 |
