-- Assume you are given the tables below containing information on Snapchat users, their ages, 
    --and their time spent sending and opening snaps. 
    
--Write a query to obtain a breakdown of the time spent sending vs. opening snaps (as a percentage of total time spent on these activities) for each age group.

-- Output the age bucket and percentage of sending and opening snaps. Round the percentage to 2 decimal places.

               -- Notes: --
-- You should calculate these percentages:
-- time sending / (time sending + time opening)
-- time opening / (time sending + time opening)
-- To avoid integer division in percentages, multiply by 100.0 and not 100.


-- activities Example Table: --
| activity_id | user_id | activity_type | time_spent |    activity_date    |
|:-----------:|:-------:|:-------------:|:----------:|:-------------------:|
|     7274    |   123   |      open     |    4.50    | 06/22/2022 12:00:00 |
|     2425    |   123   |      send     |    3.50    | 06/22/2022 12:00:00 |
|     1413    |   456   |      send     |    5.67    | 06/23/2022 12:00:00 |


-- age_breakdown Example Input: --
   | user_id | age_bucket |
   |:-------:|:----------:|
   |   123   |    31-35   |
   |   456   |    26-30   |
   |   789   |    21-25   |


-- Solution: --
SELECT age_breakdown.age_bucket, 
ROUND( SUM(send_time) / (SUM(send_time) + SUM(open_time)) * 100, 2)::numeric AS send_perc, 
ROUND( SUM(open_time) / (SUM(send_time) + SUM(open_time)) * 100, 2)::numeric AS open_perc
FROM age_breakdown
INNER JOIN 
  (SELECT user_id, SUM(time_spent) AS send_time 
   FROM activities 
   WHERE activity_type = 'send' 
   GROUP BY user_id) AS sending 
ON age_breakdown.user_id = sending.user_id
INNER JOIN 
  (SELECT user_id, SUM(time_spent) AS open_time 
   FROM activities 
   WHERE activity_type = 'open' 
   GROUP BY user_id) AS opening 
ON age_breakdown.user_id = opening.user_id
GROUP BY age_breakdown.age_bucket;


              -- Output --
| age_bucket | send_perc | open_perc |
|:----------:|:---------:|:---------:|
|    21-25   |   54.31   |   45.69   |
|    26-30   |   82.26   |   17.74   |
|    31-35   |   37.84   |   62.16   |
