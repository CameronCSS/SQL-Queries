
!! 'Data in Motion SQL Challenge #32'

-- QUESTION 1:

-- Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".

-- Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.

-- For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

-- Assumptions:

-- If two artists' songs have the same number of appearances, the artists should have the same rank.The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).

WITH ranking AS 
(
	SELECT artists.artist_name, COUNT(global_song_rank.song_id) AS artist_rank
	FROM artists
	JOIN songs 
	ON artists.artist_id = songs.artist_id
	JOIN global_song_rank 
	ON global_song_rank.song_id = songs.song_id
	WHERE global_song_rank.rank <= 10
	GROUP BY artists.artist_name
	ORDER BY artist_rank DESC
)

SELECT artist_name, artist_rank
FROM 
(
	SELECT ranking.artist_name, DENSE_RANK() OVER (ORDER BY ranking.artist_rank DESC) AS artist_rank
	FROM ranking
	ORDER BY artist_rank ASC
) AS ranked
WHERE artist_rank <= 5



-------------------------------------


-- QUESTION 2:

-- New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

-- Write a query to find the activation rate of the users. Round the percentage to 2 decimal places.

-- Definitions:
	-- emails table contain the information of user signup details.
	-- texts table contains the users' activation information.

    
WITH confirmed AS (
SELECT emails.user_id, texts.signup_action, emails.email_id 
FROM emails
JOIN texts 
ON emails.email_id = texts.email_id
WHERE texts.signup_action = 'Confirmed'
)


SELECT ROUND(COUNT(confirmed.signup_action) / COUNT(emails.user_id):: numeric, 2) AS confirm_rate
FROM confirmed
FULL OUTER JOIN emails
ON emails.email_id = Confirmed.email_id

