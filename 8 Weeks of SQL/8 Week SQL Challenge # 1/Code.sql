-- Create the tables

-- SALES TABLE

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
 
 -- MENU TABLE

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
  
-- MEMBERS TABLE

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
------------ 

1. -- What is the total amount each customer spent at the restaurant? 

-- OLD Code

SELECT customer_id, SUM(price) AS total_spent
  FROM sales
JOIN menu ON sales.product_id = menu.product_id
  GROUP BY customer_id;

-- UPDATED Code

SELECT 
	customer_id,
	SUM(price) AS total_spent
FROM sales s 
JOIN menu m 
ON s.product_id = m.product_id 
GROUP BY customer_id;




2. -- How many days has each customer visited the restaurant?

-- OLD Code
  
  SELECT customer_id, COUNT(DISTINCT order_date) as days_visited
FROM sales
GROUP BY customer_id;

-- UPDATED Code

SELECT 
	customer_id,
	COUNT(DISTINCT order_date) AS days_visited
FROM sales s
GROUP BY customer_id;





3. -- What was the first item from the menu purchased by each customer?

-- OLD Code

SELECT sales.customer_id, menu.product_name, Order_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN (
  SELECT customer_id, MIN(order_date) AS first_order_date
  FROM sales
  GROUP BY customer_id
) FirstOrder ON sales.customer_id = FirstOrder.customer_id AND sales.order_date = FirstOrder.first_order_date;

-- UPDATED Code

SELECT 
    customer_id, 
    GROUP_CONCAT(product_name, ', ') AS ordered_items,
    order_date
FROM (
    SELECT 
        s.customer_id, 
        m.product_name, 
        s.order_date,
        ROW_NUMBER() OVER (PARTITION BY s.customer_id, s.order_date, m.product_name ORDER BY s.order_date) AS rn
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    WHERE s.order_date IN (
        SELECT MIN(order_date)
        FROM sales
        GROUP BY customer_id
    )
) AS subquery
WHERE rn = 1
GROUP BY customer_id, order_date
ORDER BY customer_id, order_date;




4. -- What is the most purchased item on the menu and how many times was it purchased by all customers?

-- OLD Code

SELECT menu.product_name, COUNT(sales.product_id) as number_purchased
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY menu.product_name
ORDER BY number_purchased DESC;

-- UPDATED Code

WITH purchases AS (
    SELECT
        m.product_name,
        COUNT(s.product_id) AS number_purchased
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY m.product_name
),
most AS (
    SELECT
        product_name
    FROM purchases p
    WHERE number_purchased = (
        SELECT MAX(number_purchased)
        FROM purchases p
    )
)
SELECT 
    product_name,
    COUNT(order_date) AS total_orders,
    customer_id AS customer
FROM most
JOIN sales s
GROUP BY customer_id, product_name




5. -- Which item was the most popular for each customer?

-- OLD Code

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

-- UPDATED Code

   WITH purchases AS (
	  SELECT 
		  sales.customer_id, 
		  menu.product_name, 
		  COUNT(sales.product_id) as number_purchased,
		  RANK() OVER (PARTITION BY sales.customer_id ORDER BY COUNT(sales.product_id) DESC) AS ranking
	  FROM sales
	  JOIN menu ON sales.product_id = menu.product_id
	  GROUP BY sales.customer_id, menu.product_name
)

SELECT 
customer_id, 
product_name, 
number_purchased
FROM purchases
WHERE ranking = 1;




6. -- Which item was purchased first by the customer after they became a member?

-- OLD Code

SELECT sales.customer_id, menu.product_name, sales.order_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date > members.join_date;

-- UPDATED Code

SELECT 
    customer_id,
    product_name,
    order_date
FROM (
    SELECT 
        mem.customer_id,
        m.product_name, 
        s.order_date,
        ROW_NUMBER() OVER (PARTITION BY mem.customer_id ORDER BY s.order_date) AS rn
    FROM members mem
    JOIN sales s  
        ON s.customer_id = mem.customer_id
    JOIN menu m
        ON m.product_id = s.product_id
    WHERE s.order_date > mem.join_date
) AS a
WHERE rn = 1;




7. -- Which item was purchased just before the customer became a member?

-- OLD Code

SELECT sales.customer_id, menu.product_name, sales.order_date, members.join_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
ORDER BY sales.customer_id, sales.order_date DESC;

-- UPDATED Code

SELECT 
    customer_id,
    product_name,
    order_date
FROM (
    SELECT 
        mem.customer_id,
        m.product_name, 
        s.order_date,
        ROW_NUMBER() OVER (PARTITION BY mem.customer_id ORDER BY s.order_date desc) AS rn
    FROM members mem
    JOIN sales s  
        ON s.customer_id = mem.customer_id
    JOIN menu m
        ON m.product_id = s.product_id
    WHERE s.order_date < mem.join_date
) AS a
WHERE rn = 1;




8. -- What is the total items and amount spent for each member before they became a member?

-- OLD Code

SELECT sales.customer_id, COUNT(sales.product_id) as number_items, SUM(menu.price) as amount_spent
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
GROUP BY sales.customer_id;

-- UPDATED Code

SELECT 
	s.customer_id, 
	COUNT(s.product_id) as num_items, 
	SUM(m.price) as spent
FROM sales s
JOIN menu m
	ON s.product_id = m.product_id
JOIN members mem
	ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id;




9. -- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

-- OLD Code

SELECT sales.customer_id, 
  SUM((CASE 
    WHEN menu.product_name = 'sushi' THEN menu.price * 2 
	    ELSE menu.price END) * 10) AS total_points
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;

-- UPDATED Code

SELECT s.customer_id, 
  SUM((
  CASE 
    WHEN product_name = 'sushi' THEN price * 2 
	ELSE price END) * 10) AS total_points
FROM sales s
JOIN menu m 
	ON s.product_id = m.product_id
JOIN members mem
	ON mem.customer_id = s.customer_id
GROUP BY s.customer_id HAVING COUNT(join_date) <> 0;




10. -- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi
-- how many points do customer A and B have at the end of January?

-- OLD Code

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

-- UPDATED Code

WITH purchases AS (
	SELECT 
		s.customer_id,
		m.product_name,
 		m.price,
    	s.order_date,
    	mem.join_date,
    	(
    		CASE
    			WHEN product_name = 'sushi' THEN m.price * 2
    			WHEN s.order_date BETWEEN mem.join_date AND date(mem.join_date, '+6 days') THEN m.price * 2
    			ELSE m.price
    		END
    	) * 10 AS points
    FROM sales s
    JOIN menu m 
    	ON s.product_id = m.product_id
    JOIN members mem
    	ON s.customer_id = mem.customer_id
)

SELECT
	p.customer_id,
	SUM(points) AS total_points
FROM purchases p
WHERE order_date < (SELECT date(join_date, 'start of month', '+1 month', '-1 day') FROM members)
GROUP BY p.customer_id;


