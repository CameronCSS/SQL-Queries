-- CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. 
-- Each drug can only be produced by one manufacturer.

-- Write a query to find the top 3 most profitable drugs sold, and how much profit they made. 
-- Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

  -- Definition: --
-- cogs stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
-- Total Profit = Total Sales - Cost of Goods Sold


-- pharmacy_sales Example Table: --
| product_id | units_sold | total_sales |    cogs   | manufacturer |       drug      |
|:----------:|:----------:|:-----------:|:---------:|:------------:|:---------------:|
|      9     |    37410   |  293452.54  | 208876.01 |   Eli Lilly  |     Zyprexa     |
|     34     |    94698   |  600997.19  | 521182.16 |  AstraZeneca |    Surmontil    |
|     61     |    77023   |  500101.61  | 419174.97 |    Biogen    | Varicose Relief |


-- Solution: --
WITH profits AS (
    SELECT drug, (total_sales - cogs) AS total_profit 
    FROM pharmacy_sales
)
SELECT drug, total_profit
FROM profits
ORDER BY total_profit DESC
LIMIT 3;


       -- Output --
|   drug   | total_profit |
|:--------:|:------------:|
|  Humira  |  81515652.55 |
| Keytruda |  11622022.02 |
| Dupixent |  11217052.34 |
