-- Assume that you are given the table below containing information on viewership by device type.
-- Define “mobile” as the sum of tablet and phone viewership numbers. 
-- Write a query to compare the viewership on laptops versus mobile devices.

-- Output the total viewership for laptop and mobile devices in the format of "laptop_views" and "mobile_views".


       -- viewership Example Table: --
| user_id | device_type | view_time           |
|---------|-------------|---------------------|
| 123     | tablet      | 01/02/2022 00:00:00 |
| 125     | laptop      | 01/07/2022 00:00:00 |
| 129     | phone       | 02/09/2022 00:00:00 |


-- Solution: --
WITH mobile AS (
SELECT user_id, COUNT(view_time) AS mob_views
FROM viewership
WHERE device_type IN ('tablet', 'phone')
GROUP BY user_id
),
laptop AS (
SELECT user_id, COUNT(view_time) AS lap_views
FROM viewership
WHERE device_type = 'laptop'
GROUP BY user_id
)

SELECT COUNT(lap_views) AS laptop_views, COUNT(mob_views) AS mobile_views
FROM mobile
FULL OUTER JOIN laptop
ON mobile.user_id = laptop.user_id

-- Output --
| laptop_views | mobile_views |
|--------------|--------------|
| 2            | 3            |
