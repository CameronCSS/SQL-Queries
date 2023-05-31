-- Passanger is Alone
SELECT *
FROM [dataset_1]
WHERE passanger LIKE "Alone%";


-- Average Temperature by Destination
SELECT destination, ROUND(AVG(Temperature),1)
FROM dataset_1
GROUP BY destination;


-- Min temp by destination
SELECT destination, MIN(Temperature)
FROM dataset_1 d 
GROUP BY destination;


-- Union
SELECT *
FROM dataset_1 d 
UNION
SELECT *
FROM table_to_unionl;


-- Joining
SELECT *
FROM table_to_join ttj;


--Aliasing and Joining with ttj data (Right Join)
SELECT d.destination, d.time, ttj.part_of_day
FROM dataset_1 d 
RIGHT JOIN table_to_join ttj 
ON d.time = ttj.time;


-- Aliasing with ALL d data (Left Join)
SELECT d.destination, d.time, ttj.part_of_day
FROM dataset_1 d 
LEFT JOIN table_to_join ttj 
ON d.time = ttj.time;


-- Using CASE WHEN to get the same data as TTJ
SELECT 
    destination,
	time,
	CASE 
		WHEN time = '10AM' OR time = '7AM' THEN 'Morning'
		WHEN time = '2PM' THEN 'Afternoon'
		WHEN time = '6PM' THEN 'Evening'
		WHEN time = '10PM' THEN 'Evening'
	END AS part_of_day
FROM dataset_1 d
GROUP BY time;
	

--Advanced Aggregation
SELECT
	destination,
	weather,
	AVG(temperature) OVER (PARTITION BY weather) AS 'avg_temp_by_weather'
FROM dataset_1 d


-- Row Numbers
SELECT
	destination,
	weather,
	ROW_NUMBER() OVER (PARTITION BY weather ORDER BY destination)
FROM dataset_1 d 


-- Ranking shows ties, but skips to Actual tied count on next rank
SELECT
	destination,
	weather,
	RANK() OVER (PARTITION BY weather ORDER BY destination) AS 'avg_temp_by_weather'
FROM dataset_1 d;


-- Dense Rank shows ties but goes to next Rank 1,2,3, etc. no matter how many ties
SELECT
	destination,
	weather,
	DENSE_RANK() OVER (PARTITION BY weather ORDER BY destination) AS 'avg_temp_by_weather'
FROM dataset_1 d;
	