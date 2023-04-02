-- Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

-- Assumption: There are no duplicates in the candidates table.


-- candidates Example Input: --
   | candidate_id	 |    skill    |
        123        |    Python
        123        |    Tableau
        123        |    PostgreSQL
        234        |    R
        234        |    PowerBI
        234        |    SQL Server
        345        |    Python
        345        |    Tableau
        

-- Solution: --

SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3

-- Output --
| candidate_id |
      123
      147
