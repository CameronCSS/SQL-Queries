-- Stratascratch Question:
-- Difficulty: Hard
-- 'Host Popularity Rental Prices'
-- Available at https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices

SELECT 
    popularity_rating,
    MIN(price) AS min_price,
    AVG(price) AS avg_price,
    MAX(price) AS max_price
FROM (
    SELECT
        host_id,
        price,
        popularity_rating
    FROM
        (
        SELECT
            price || room_type || host_since || zipcode || number_of_reviews AS host_id,
            -- Double pipe || acts the same as a CONCAT function
            price,
            CASE
                WHEN number_of_reviews = 0
                    OR number_of_reviews IS NULL THEN 'New'
                WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
                WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
                WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
                WHEN number_of_reviews > 40 THEN 'Hot'
            END AS popularity_rating
        FROM 
            airbnb_host_searches
        ) a
    GROUP BY 
        host_id,
        price,
        popularity_rating
    ) b
GROUP BY popularity_rating;