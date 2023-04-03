-- Assume you are given the table below on Uber transactions made by users. 
-- Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

-- transactions Example Table: --
| user_id | spend  | transaction_date    |
|---------|--------|---------------------|
| 111     | 100.50 | 01/08/2022 12:00:00 |
| 111     | 55.00  | 01/10/2022 12:00:00 |
| 121     | 36.00  | 01/18/2022 12:00:00 |

-- Solution: --
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
