-- Basic SELECT. * represents ALL data. its a simple way to get all data from the db
SELECT *
FROM dataset_1;


-- Basic WHERE
SELECT *
FROM dataset_1
WHERE passanger = "Alone"; 
-- I know its mispelled. Its mispelled in the Dataset.


-- Average (Temperature by Destination)
SELECT 
	destination, 
	AVG(Temperature)
FROM dataset_1
GROUP BY destination;


-- Rounding our Average (Temperature by Destination)
SELECT 
	destination, 
	ROUND(AVG(Temperature),1)
FROM dataset_1
GROUP BY destination;


-- Min temp by destination
SELECT 
	destination, 
	MIN(Temperature)
FROM dataset_1 
GROUP BY destination;


-- Max temp by destination
SELECT 
	destination, 
	MAX(Temperature)
FROM dataset_1
GROUP BY destination;


-- Union Stacks the second table under the original, and removes duplicates.
SELECT *
FROM dataset_1 d 
UNION
SELECT *
FROM table_to_union;


-- Union ALL Stacks the second table under the original. Duplicates will remain since it leaves ALL data
SELECT *
FROM dataset_1
UNION
SELECT *
FROM table_to_union;


-- Basic Joining merges the two tables. SQL will handle duplicates depending on what type of JOIN you use
SELECT *
FROM dataset_1
JOIN table_to_join
ON dataset_1.time = table_to_join.time;


-- Aliasing and Joining with ttj data 
-- (Right Join keeps the SECOND table data, and only brings in MATCHING data from the first mentioned table)
SELECT 
	d.destination, 
	d.time, 
	ttj.part_of_day
FROM dataset_1 d 
RIGHT JOIN table_to_join ttj 
ON d.time = ttj.time;
--Aliasing saves a tone of time. But make sure you do it in a readable way that doesnt confuse Users


-- Aliasing with ALL d data (Left Join brings ALL data from the first mentioned table, and only matching data from the second)
SELECT 
	d.destination, 
	d.time, 
	ttj.part_of_day
FROM dataset_1 d 
LEFT JOIN table_to_join ttj 
ON d.time = ttj.time;


-- Using CASE WHEN to get the same data as TTJ table was adding
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
	

-- Advanced Aggregation
-- This gets the Average temp for EACH weather item. and then adds that data into each row via temp column called 'avg_temp_by_weather'
SELECT
	destination,
	weather,
	AVG(temperature) OVER (PARTITION BY weather) AS 'avg_temp_by_weather'
FROM dataset_1 d


-- Row Numbers
-- Gives us the data we called, and adds a new column that displays the row number of each item
SELECT
	destination,
	weather,
	ROW_NUMBER() OVER (PARTITION BY weather ORDER BY destination)
FROM dataset_1 d 


-- Ranking shows ties, but skips to Actual tied count on next rank. I.E. 1,255,768 etc.
SELECT
	destination,
	weather,
	RANK() OVER (PARTITION BY weather ORDER BY destination) AS 'avg_temp_by_weather'
FROM dataset_1 d;


-- Dense Rank shows ties but goes to next Rank in order 1,2,3, etc. no matter how many ties it goes to the next Counted number.
SELECT
	destination,
	weather,
	DENSE_RANK() OVER (PARTITION BY weather ORDER BY destination) AS 'avg_temp_by_weather'
FROM dataset_1 d;
	

-- Ntiles: 
-- The NTILE function divides the result set into approximately equal-sized buckets or groups. In this case, it divides the rows into 50 groups.
SELECT 
	time, 
	NTILE (50) OVER (ORDER BY time)
FROM dataset_1 d;


-- LAG Function
-- This will show us the row number of the PREVIOUS row to the one the data is inserted.
-- Since the first row doesnt have a previous row, we can just call it FIRST 
-- Normally you would do this to compare actual values not just row numbers
SELECT 
	destination, 
	time, 
	LAG(row_count , 1, 'FIRST') OVER (ORDER BY row_count) AS 'LaggedCount' 
FROM dataset_1 d;


-- LEAD Function
-- This will show us the row number of the NEXT row to the one the data is inserted.
-- Since the last row doesnt have a next row, we can just call it LAST 
-- Normally you would do this to compare actual values not just row numbers
SELECT 
	destination, 
	time, 
	LEAD(row_count , 1, 'LAST') OVER (ORDER BY row_count) AS 'LaggedCount' 
FROM dataset_1;
