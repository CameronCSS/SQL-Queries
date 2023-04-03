-- CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. 
-- Each drug can only be produced by one manufacturer.

-- Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 

-- Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. 
-- Display the results with the highest losses on top.


                            -- pharmacy_sales Example Table: --
| product_id | units_sold | total_sales |    cogs    | manufacturer |            drug           |
|:----------:|:----------:|:-----------:|:----------:|:------------:|:-------------------------:|
|     156    |    89514   |  3130097.00 | 3427421.73 |    Biogen    |         Acyclovir         |
|     25     |   222331   |  2753546.00 | 2974975.36 |    AbbVie    | Lamivudine and Zidovudine |
|     50     |    90484   |  2521023.73 | 2742445.90 |   Eli Lilly  | Dermasorb TA Complete Kit |


-- Solution: --
WITH loss AS (
  SELECT manufacturer, drug, (total_sales - cogs) AS total_loss
  FROM pharmacy_sales
  WHERE cogs > total_sales
  )
  
  SELECT manufacturer, COUNT(drug) AS drug_count, ABS(SUM(total_loss)) AS total_loss
  FROM loss
  GROUP BY manufacturer
  ORDER BY total_loss  DESC
  
  
                 -- Output --
|    manufacturer   | drug_count | total_loss |
|:-----------------:|:----------:|:----------:|
| Johnson & Johnson |      6     |  894913.13 |
|     Eli Lilly     |      4     |  447352.90 |
|       Biogen      |      3     |  417018.89 |
|       AbbVie      |      2     |  413991.10 |
|       Roche       |      2     |  159741.62 |
|       Bayer       |      1     |  28785.28  |
