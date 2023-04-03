-- New TikTok users sign up with their emails and each user receives a text confirmation to activate their account. 
-- Assume you are given the below tables about emails and texts.

-- Write a query to display the ids of the users who did not confirm on the first day of sign-up, but confirmed on the second day.

-- Assumption: --
-- action_date is the date when the user activated their account and confirmed their sign-up through the text.


      -- emails Example Input: --
| email_id | user_id |     signup_date     |
|:--------:|:-------:|:-------------------:|
|    125   |   7771  | 06/14/2022 00:00:00 |
|    433   |   1052  | 07/09/2022 00:00:00 |


-- Solution: --
WITH confirmed AS (
SELECT e.user_id, e.email_id, signup_date, action_date
FROM emails e
FULL OUTER JOIN texts t
ON  t.email_id = e.email_id
WHERE signup_action = 'Confirmed'
)

SELECT user_id
FROM confirmed
WHERE action_date = signup_date + '1 DAY';


-- Output --
| user_id |
|:-------:|
|   1052  |
|   1235  |
