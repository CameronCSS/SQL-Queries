-- Assume you are given the table below that shows job postings for all companies on the LinkedIn platform. 
-- Write a query to get the number of companies that have posted duplicate job listings.

-- Clarification: --
-- Duplicate job listings refer to two jobs at the same company with the same title and description.


                                                    -- job_listings Example Table: --
| job_id | company_id |       title      |                                                                  description                                                                 |
|:------:|:----------:|:----------------:|:--------------------------------------------------------------------------------------------------------------------------------------------:|
|   248  |     827    | Business Analyst | Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations. |
|   149  |     845    | Business Analyst | Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations. |
|   945  |     345    |   Data Analyst   |        Data analyst reviews data to identify key insights into a business's customers and ways the data can be used to solve problems.       |


-- Solution: --
WITH jobs AS (
SELECT COUNT(job_id) AS job_count, company_id, title, description
FROM job_listings
GROUP BY company_id, title, description
),
counted AS (
SELECT company_id, title, description
FROM jobs
GROUP BY job_count, company_id, title, description 
HAVING job_count > 1
)

SELECT COUNT(*) AS co_w_duplicate_jobs
FROM counted

-- Output --
| co_w_duplicate_jobs |
|:-------------------:|
|          3          |
