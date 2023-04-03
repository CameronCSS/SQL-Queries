-- Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. 
-- Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending count of the messages.

-- Assumption: --
-- No two users has sent the same number of messages in August 2022.

                         -- messages Example Table: --
| message_id | sender_id | receiver_id |         content         |      sent_date      |
|:----------:|:---------:|:-----------:|:-----------------------:|:-------------------:|
|     901    |    3601   |     4500    |         You up?         | 08/03/2022 00:00:00 |
|     902    |    4500   |     3601    |  Only if you're buying  | 08/03/2022 00:00:00 |
|     743    |    3601   |     8752    | Let's take this offline | 06/14/2022 00:00:00 |


-- Solution: --
SELECT sender_id, COUNT(message_id) AS message_count
FROM messages
WHERE DATE_PART('year', sent_date) = 2022 AND DATE_PART('month', sent_date) = 8
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2


      -- Output --
| sender_id | message_count |
|:---------:|:-------------:|
|    3601   |       4       |
|    2520   |       3       |
