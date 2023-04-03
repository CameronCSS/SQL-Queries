-- Given the reviews table, write a query to get the average stars for each product every month.

- The output should include the month in numerical value, product id, and average star rating rounded to two decimal places.
-- Sort the output based on month followed by the product id.


                  -- reviews Example Table: --
| review_id | user_id |     submit_date     | product_id | stars |
|:---------:|:-------:|:-------------------:|:----------:|:-----:|
|    6171   |   123   | 06/08/2022 00:00:00 |    50001   |   4   |
|    7802   |   265   | 06/10/2022 00:00:00 |    69852   |   4   |
|    5293   |   362   | 06/18/2022 00:00:00 |    50001   |   3   |


-- Solution: --
SELECT EXTRACT(MONTH FROM submit_date) AS mth, product_id AS product, ROUND(AVG(stars),2):: NUMERIC AS avg_stars
FROM reviews
GROUP BY product, mth
ORDER BY mth, product


      -- Output --
| mth | product | avg_stars |
|:---:|:-------:|:---------:|
|  5  |  25255  |    4.00   |
|  5  |  25600  |    4.33   |
|  6  |  12580  |    4.50   |
|  6  |  50001  |    3.50   |
|  6  |  69852  |    4.00   |
|  7  |  11223  |    5.00   |
|  7  |  69852  |    2.50   |
