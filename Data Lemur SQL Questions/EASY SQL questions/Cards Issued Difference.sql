-- Your team at JPMorgan Chase is soon launching a new credit card, and to gain some context, 
    -- you are analyzing how many credit cards were issued each month.

-- Write a query that outputs the name of each credit card and the difference in issued amount between the month with the most cards issued, 
    -- and the least cards issued. Order the results according to the biggest difference.
    
    
                -- monthly_cards_issued Example Table: --
|        card_name       | issued_amount | issue_month | issue_year |
|:----------------------:|:-------------:|:-----------:|:----------:|
|   Chase Freedom Flex   |     55000     |      1      |    2021    |
|   Chase Freedom Flex   |     70000     |      4      |    2021    |
| Chase Sapphire Reserve |     170000    |      1      |    2021    |


-- Solution: --
WITH sums AS (
SELECT COUNT(issue_month), SUM(issued_amount) AS issued, issue_month, card_name, issue_year
FROM monthly_cards_issued
GROUP BY issue_month, card_name, issue_year
)

SELECT card_name, (MAX(issued) - MIN(issued)) AS difference
FROM sums
GROUP BY card_name
ORDER BY difference DESC



              -- Output --
|        card_name       | difference |
|:----------------------:|:----------:|
| Chase Sapphire Reserve |    30000   |
|   Chase Freedom Flex   |    15000   |
