CREATE DATABASE pizza_sales;

USE pizza_sales;

CREATE TABLE order_details (
    order_details_id INT,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT
);

BULK INSERT order_details
FROM 'order_details.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE orders (
    order_id INT,
    date DATE,
    time DATETIME
);

BULK INSERT orders
FROM 'orders.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50),
    name VARCHAR(50),
    category VARCHAR(50),
	ingredients VARCHAR(100)
);

BULK INSERT pizza_types
FROM 'pizza_types.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE pizzas (
    pizza_id VARCHAR(50),
    pizza_type_id VARCHAR(50),
    size VARCHAR(50),
	price FLOAT
);

BULK INSERT pizzas
FROM 'pizzas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT TOP 5 * FROM pizzas;


SELECT COUNT(*) AS CHEESE FROM order_details
	Where pizza_id LIKE '%cheese%'
;



SELECT COUNT(*) AS MEAT FROM order_details
	Where pizza_id LIKE '%meat%'
;



SELECT pizza_id, COUNT(DISTINCT pizza_id) FROM order_details
GROUP BY pizza_id
;



SELECT TOP 10 * FROM order_details
ORDER BY quantity DESC


SELECT TOP 10 pizza_id, COUNT(*) AS p_count
FROM order_details
GROUP BY pizza_id
ORDER BY p_count DESC



SELECT SUM(p_count) AS ckn_count
FROM (
    SELECT pizza_id, COUNT(*) AS p_count
    FROM order_details
    WHERE pizza_id LIKE '%ckn%'
    GROUP BY pizza_id
) subquery


SELECT SUM(p_count) AS pepperoni_count
FROM (
    SELECT pizza_id, COUNT(*) AS p_count
    FROM order_details
    WHERE pizza_id LIKE '%pepperoni%'
    GROUP BY pizza_id
) subquery


SELECT SUM(p_count) AS cheese_count
FROM (
    SELECT pizza_id, COUNT(*) AS p_count
    FROM order_details
    WHERE pizza_id LIKE '%cheese%'
    GROUP BY pizza_id
) subquery


SELECT SUM(p_count) AS large_count
FROM (
    SELECT pizza_id, COUNT(*) AS p_count
    FROM order_details
    WHERE pizza_id LIKE '%_l'
    GROUP BY pizza_id
) subquery


SELECT SUM(p_count) AS med_count
FROM (
    SELECT pizza_id, COUNT(*) AS p_count
    FROM order_details
    WHERE pizza_id LIKE '%_m'
    GROUP BY pizza_id
) subquery


SELECT SUM(p_count) AS small_count
FROM (
    SELECT pizza_id, COUNT(*) AS p_count
    FROM order_details
    WHERE pizza_id LIKE '%_s'
    GROUP BY pizza_id
) subquery




SELECT TOP 5
    COALESCE(large.pizza_id, med.pizza_id, small.pizza_id) AS pizza_id,
    COALESCE(large.large_count, 0) AS large_count,
    COALESCE(med.med_count, 0) AS med_count,
    COALESCE(small.small_count, 0) AS small_count,
    (COALESCE(large.large_count, 0) + COALESCE(med.med_count, 0) + COALESCE(small.small_count, 0)) AS total_count

FROM
    (
	SELECT LEFT(pizza_id, LEN(pizza_id) - 2) AS pizza_id, COUNT(*) AS large_count
		FROM order_details
			WHERE pizza_id LIKE '%_l'
			GROUP BY LEFT(pizza_id, LEN(pizza_id) - 2)) AS large
    FULL OUTER JOIN 
    (
	SELECT LEFT(pizza_id, LEN(pizza_id) - 2) AS pizza_id, COUNT(*) AS med_count
		FROM order_details
			WHERE pizza_id LIKE '%_m'
			GROUP BY LEFT(pizza_id, LEN(pizza_id) - 2)) AS med
		ON large.pizza_id = med.pizza_id
    FULL OUTER JOIN
    (
	SELECT LEFT(pizza_id, LEN(pizza_id) - 2) AS pizza_id, COUNT(*) AS small_count
		FROM order_details
			WHERE pizza_id LIKE '%_s'
			GROUP BY LEFT(pizza_id, LEN(pizza_id) - 2)) AS small
		ON COALESCE(large.pizza_id, med.pizza_id) = small.pizza_id

ORDER BY total_count DESC;


SELECT * FROM orders;

WITH DayOfWeek AS (
  SELECT order_id, DATENAME(dw, date) AS day_of_week
  FROM orders
)

SELECT day_of_week, COUNT(order_id) AS Count
FROM DayOfWeek
GROUP BY day_of_week

SELECT TOP 5 * FROM pizzas
ORDER BY price DESC;


SELECT 'Hawaiian' AS pizza_name, COUNT(*) AS Order_count
FROM order_details
WHERE pizza_id LIKE '%hawaiian%'
UNION ALL
SELECT 'Pepperoni' AS pizza_name, COUNT(*) AS Order_count
FROM order_details
WHERE pizza_id LIKE '%pepperoni%';



