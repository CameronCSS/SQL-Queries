-- Assume you have an events table on app analytics. 
--Write a query to get the app’s click-through rate (CTR %) in 2022. Output the results in percentages rounded to 2 decimal places.

-- Notes: --
-- Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions
-- To avoid integer division, you should multiply the click-through rate by 100.0, not 100.


        -- events Example Table: --
| app_id | event_type |      timestamp      |
|:------:|:----------:|:-------------------:|
|   123  | impression | 07/18/2022 11:36:12 |
|   123  | impression | 07/18/2022 11:37:12 |
|   123  |    click   | 07/18/2022 11:37:42 |


-- Solution: --
SELECT app_id, 
ROUND(100 * 
COUNT(CASE WHEN event_type = 'click' THEN 1 END)::NUMERIC
/
COUNT(CASE WHEN event_type = 'impression' THEN 1 END)::NUMERIC ,2) AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id


   -- Output -- 
| app_id |  ctr  |
|:------:|:-----:|
|   123  | 66.67 |
|   234  | 33.33 |
