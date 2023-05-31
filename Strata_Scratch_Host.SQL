-- Stratascratch Question:
-- Difficulty: Medium
-- 'Favorite Host Nationality'
-- Available at https://platform.stratascratch.com/coding/10073-favorite-host-nationality

-- from-user is the reviewer
-- to_user is the host they rated
-- review_score is the score they gave

WITH max_scores AS
    (
    SELECT
        from_user,
        nationality,
        review_score,
        MAX(review_score) OVER (PARTITION BY from_user) AS max_review_score
    FROM airbnb_reviews r
    LEFT JOIN airbnb_hosts h
    ON r.to_user = h.host_id
    WHERE  from_type = 'guest'
    )
    
SELECT
    from_user,
    nationality
FROM max_scores
WHERE review_score = max_review_score
GROUP BY 
    from_user,
    nationality
ORDER BY 
    from_user;