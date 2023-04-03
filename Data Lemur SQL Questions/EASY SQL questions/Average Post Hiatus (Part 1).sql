-- Given a table of Facebook posts, for each user who posted at least twice in 2021
-- Write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021.
-- Output the user and number of the days between each user's first and last post.


             -- posts Example Table: --
| user_id | post_id |      post_date      |    post_content    |
|:-------:|:-------:|:-------------------:|:------------------:|
|  151652 |  599415 | 07/10/2021 12:00:00 |     Need a hug     |
|  004239 |  784254 | 07/04/2021 11:00:00 | Happy 4th of July! |


-- Solution: --
SELECT user_id, 
DATE_PART('day', MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id HAVING COUNT(post_date) > 1


-- Output --
| user_id | days_between |
|:-------:|:------------:|
|  151652 |      307     |
|  661093 |      206     |
