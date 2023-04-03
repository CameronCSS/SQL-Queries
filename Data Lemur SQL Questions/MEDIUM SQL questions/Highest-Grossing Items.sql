-- Assume you are given the table containing information on Amazon customers and their spending on products in various categories.

-- Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.


               -- product_spend Example Table: --
|  category |     product     | user_id |  spend |   transaction_date  |
|:---------:|:---------------:|:-------:|:------:|:-------------------:|
| appliance |   refrigerator  |   165   | 246.00 | 12/26/2021 12:00:00 |
| appliance |   refrigerator  |   123   | 299.99 | 03/02/2022 12:00:00 |
| appliance | washing machine |   123   | 219.80 | 03/02/2022 12:00:00 |


-- Solution: --
WITH rank AS (
SELECT category, DENSE_RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS product_rank, 
       product, SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(year FROM transaction_date) = 2022
GROUP BY category, product
ORDER BY category, total_spend DESC
)


SELECT category, product, total_spend FROM rank
WHERE product_rank <= 2


                 -- Output --
|   category  |      product     | total_spend |
|:-----------:|:----------------:|:-----------:|
|  appliance  |  washing machine |    439.80   |
|  appliance  |   refrigerator   |    299.99   |
| electronics |      vacuum      |    486.66   |
| electronics | wireless headset |    447.90   |
