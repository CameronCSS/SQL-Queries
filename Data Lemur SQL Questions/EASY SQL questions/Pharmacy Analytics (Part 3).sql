-- CVS Health is trying to better understand its pharmacy sales, and how well different products are selling.

-- Write a query to find the total drug sales for each manufacturer. 
-- ound your answer to the closest million, and report your results in descending order of total sales.

-- Because this data is being directly fed into a dashboard which is being seen by business stakeholders, format your result like this: "$36 million".


                      -- pharmacy_sales Example Input: --
| product_id | units_sold | total_sales |    cogs    | manufacturer |    drug   |
|:----------:|:----------:|:-----------:|:----------:|:------------:|:---------:|
|     94     |   132362   |  2041758.41 | 1373721.70 |    Biogen    | UP and UP |
|      9     |    37410   |  293452.54  |  208876.01 |   Eli Lilly  |  Zyprexa  |
|     50     |    90484   |  2521023.73 |  2742445.9 |   Eli Lilly  | Dermasorb |


-- Solution: --
SELECT manufacturer, CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS total_sales
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC


           -- Output --
|    manufacturer   |  total_sales |
|:-----------------:|:------------:|
|       AbbVie      | $114 million |
|     Eli Lilly     |  $82 million |
|       Biogen      |  $70 million |
| Johnson & Johnson |  $43 million |
|       Bayer       |  $34 million |
|    AstraZeneca    |  $32 million |
|       Pfizer      |  $28 million |
|       Merck       |  $27 million |
|      Novartis     |  $26 million |
|       Sanofi      |  $25 million |
|       Roche       |  $16 million |
|  GlaxoSmithKline  |  $4 million  |
