-- Assume you are given the tables below about Facebook pages and page likes. 
-- Write a query to return the page IDs of all the Facebook pages that don't have any likes. The output should be in ascending order.

-- pages Table: --                    -- page_likes Table: --

| Column Name | Type    |            | Column Name | Type     |
|-------------|---------|            |-------------|----------|
| user_id     | integer |            | page_id     | integer  |
| page_id     | integer |            | page_name   | varchar  |
|             |         |            | liked_date  | datetime |
       

-- Solution: --
select pages.page_id
FROM pages
LEFT JOIN page_likes
ON pages.page_id = page_likes.page_id
GROUP BY pages.page_id
HAVING COUNT(liked_date) = 0

-- Output: --
| page_id |
|---------|
| 20701   |
| 32728   |
