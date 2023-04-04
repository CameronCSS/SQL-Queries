-- Data in Motion SQL Challenge # 31

-- PART 1

-- Write a query to find the top 3 most profitable drugs sold, and how much profit they made. 
-- Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

WITH profits AS (
    SELECT drug, (total_sales - cogs) AS total_profit 
    FROM pharmacy_sales
)
SELECT drug, total_profit
FROM profits
ORDER BY total_profit DESC
LIMIT 3;

-- Part 2

-- Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 

-- Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. Display the results with the highest losses on top.

WITH loss AS (
  SELECT manufacturer, drug, (total_sales - cogs) AS total_loss
  FROM pharmacy_sales
  WHERE cogs > total_sales
  )
  
  SELECT manufacturer, COUNT(drug) AS drug_count, ABS(SUM(total_loss)) AS total_loss
  FROM loss
  GROUP BY manufacturer
  ORDER BY total_loss  DESC
  
-- Part 3
  
-- Write a query to find the total sales of drugs for each manufacturer. Round your answer to the closest million, 
-- and report your results in descending order of total sales.
-- format your result like this: "$36 million".

SELECT manufacturer, CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS total_sales
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC
