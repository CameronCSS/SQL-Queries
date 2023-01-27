# Generic SQL 
 - language: SQL 
 *.sql linguist-language=sql

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  SELECT customer_id, SUM(price) AS total_spent
  FROM sales
JOIN menu ON sales.product_id = menu.product_id
  GROUP BY customer_id;
  
  SELECT customer_id, COUNT(DISTINCT order_date) as days_visited
FROM sales
GROUP BY customer_id;

SELECT sales.customer_id, menu.product_name, Order_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN (
  SELECT customer_id, MIN(order_date) AS first_order_date
  FROM sales
  GROUP BY customer_id
) FirstOrder ON sales.customer_id = FirstOrder.customer_id AND sales.order_date = FirstOrder.first_order_date;

SELECT menu.product_name, COUNT(sales.product_id) as number_purchased
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY menu.product_name
ORDER BY number_purchased DESC;

WITH purchases AS (
 SELECT sales.customer_id, menu.product_name, COUNT(sales.product_id) as number_purchased,
        RANK() OVER (PARTITION BY sales.customer_id ORDER BY COUNT(sales.product_id) DESC) AS ranking
 FROM sales
 JOIN menu ON sales.product_id = menu.product_id
 GROUP BY sales.customer_id, menu.product_name
)
SELECT customer_id, product_name, number_purchased
FROM purchases
WHERE ranking = 1;

SELECT sales.customer_id, menu.product_name, sales.order_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date > members.join_date;

SELECT sales.customer_id, menu.product_name, sales.order_date, members.join_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
ORDER BY sales.customer_id, sales.order_date DESC;

SELECT sales.customer_id, COUNT(sales.product_id) as number_items, SUM(menu.price) as amount_spent
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
GROUP BY sales.customer_id;

SELECT sales.customer_id, 
  SUM((CASE 
    WHEN menu.product_name = 'sushi' THEN menu.price * 2 
	    ELSE menu.price END) * 10) AS total_points
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;

WITH dates AS 
(
 SELECT *, 
  DATEADD(DAY, 6, join_date) AS valid_date, 
  EOMONTH('2021-01-31') AS last_day
 FROM members
),
purchases AS (
  SELECT sales.customer_id, menu.product_name, menu.price, sales.order_date,
         members.join_date,
         (CASE
         WHEN menu.product_name = 'sushi' THEN 2 * menu.price
         WHEN sales.order_date BETWEEN members.join_date AND dates.valid_date THEN menu.price * 2
            ELSE menu.price
          END) * 10 AS points
  FROM sales
  JOIN menu ON sales.product_id = menu.product_id
  JOIN members ON sales.customer_id = members.customer_id
  JOIN dates ON members.customer_id = dates.customer_id
)
SELECT purchases.customer_id, SUM(points) as total_points
FROM purchases
JOIN dates ON purchases.customer_id = dates.customer_id
WHERE order_date < dates.last_day
GROUP BY purchases.customer_id;

