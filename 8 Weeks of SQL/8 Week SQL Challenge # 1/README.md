<a name="readme-top"></a>

<a href="https://8weeksqlchallenge.com/case-study-1/" target="_blank"> LINK TO THE CHALLENGE </a>

```diff
- SPOILER -
- The following code contains the solutions to the challenge. 
- If you want to try solving it yourself, please visit the link before continuing.
```

## Introduction
Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

![image](https://user-images.githubusercontent.com/121735588/211134729-5cd5bd4d-8420-4f0e-af9e-d77394265056.png)


### Problem Statement
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

----

### Danny's Diner Data
#### *Starting SQL Script to establish the DB*
#### *I am using DBeaver for all the work here*
```sql
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

```

## Relationship Diagram

![image](https://user-images.githubusercontent.com/121735588/211181303-9898c3da-0749-4f4e-ad98-ed368dad809f.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----
### Questions

  1. What is the total amount each customer spent at the restaurant?
  2. How many days has each customer visited the restaurant?
  3. What was the first item from the menu purchased by each customer?
  4. What is the most purchased item on the menu and how many times was it purchased by all customers?
  5. Which item was the most popular for each customer?
  6. Which item was purchased first by the customer after they became a member?
  7. Which item was purchased just before the customer became a member?
  8. What is the total items and amount spent for each member before they became a member?
  9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
  10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi
  11. how many points do customer A and B have at the end of January?
  
----

### Answers

  **1. What is the total amount each customer spent at the restaurant?**

```sql
SELECT 
	customer_id,
	SUM(price) AS total_spent
FROM sales s 
JOIN menu m 
ON s.product_id = m.product_id 
GROUP BY customer_id;
```
```
-- This query will join the sales and menu tables on the product_id column
-- The SUM() function is used to calculate the total amount spent by each customer.
-- The resulting table will have two columns: customer_id and total_spent.
-- We group the results by customer_id.
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/d01573cf-0a6f-4251-b125-de0a5e7e106f)

<br>
  **2. How many days has each customer visited the restaurant?**

```sql
SELECT 
	customer_id,
	COUNT(DISTINCT order_date) AS days_visited
FROM sales s
GROUP BY customer_id;
```
```
-- This Grabs the customer ID, and then counts the Distinct number of Orders they have
-- Two columns are created, customer ID, and Days_visited, to display our info
-- We group the count By Customer ID since we want to see how many total days each Customer visited
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/7c8c4e66-95dd-4409-a42e-cc053f6260cc)

<br>
  **3. What was the first item from the menu purchased by each customer?**
  
```sql
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
```
```
-- We establish our main columns as customer id, and Product name, and order date
-- Then we have to join the sales and menu tables with their corresponding Key
-- Next we do a Self join creating a Temp Table called FirstOrder *(temp name goes after our inner select statement)*
-- In the Select statement of our temp table we are identifying their first order with MIN(order_date)
-- Creating this temp table saves us from having to use a self-join with multiple MIN function calls
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/fc7a9468-f7a6-42fd-9643-3e5c5ffcd600)

<br>

 **4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
```sql
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
 ```
 ```
 -- We establish how many of each product was purchased in our first CTE
 -- We then use a second CTE to define the product that was purchased the most
 -- We then join the Sales table and our CTE data to get our final results
 -- We then GROUP BY customer and product so we get a total count that each customer purchased said item
 -- We alias our columns to make them more readable
 ```
 ![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/89eb96ae-a3ef-4dc5-895d-6f5ff5829617)

<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

 **5. Which item was the most popular for each customer?**
```sql
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
 ```
 ```
 -- We create a CTE (common table expression) *which is like a temp table* By beginning with a WITH statement
 -- Instead of establishing our columns, we use the CTE to establish the data we need for our answer
 -- We count each product and how many times it was purchased
 -- We use the RANK function to establish a list of Order Count from most to least (DESC)
 -- We PARTITION by customer_id so each customer has their own temp list of Ranked purchases
 -- We join the Sales and menu tables so we can get the product names for our table
 -- Remember to use the common KEY to JOIN your tables
 -- We then group the data we established in our CTE by Customer, and product
 -- NOW we establish our columns as Customer_id, product name, and number purchased.
 -- We then use a WHERE statement to only show the top ranking purchased for each customer
 -- *Notice customer B has multiple because he purchased them all the same amount
 ```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/8ba26cfe-f485-4c83-950a-239f230a268f)

<br>

 **6. Which item was purchased first by the customer after they became a member?**
```sql
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
```
```
-- We first call the columns we will need for our question
-- We use a subquery to specify each piece of data and give it a row number
-- We partition by Customer_id so row numbers start over between each customer
-- we join all our tables we need for the data
-- Then we use or Row Number to only call the first row from each customer. 
-- Notice customer C doesnt show up because they never became a Member
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/0a704548-f11f-4a40-a108-ba7dcf0b8800)

<br>
  
 **7. Which item was purchased just before the customer became a member?**
```sql
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
 ```
 ```
 -- This is almost identical to the last question so we just have to alter our last query
 -- We need do still partition by customer, but this time switch order dates to desc so we find the first date JUST BEFORE they were a member. not the lowest date before.
 -- We later the WHERE filter to find orders before join date instead of after
 -- You can order however you want here.
 ```
 ![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/ab16050c-60cf-4224-8116-8cff09914864)

<br>

 **8. What is the total items and amount spent for each member before they became a member?**
```sql
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
```
```
-- We use COUNT to add up the amount of products purchased
-- SUM price is used to add up the total spent
-- We join all Tables through their common KEYS
-- We then use WHERE to filter the results so only orders BEFORE they joined are included
-- Finally we group by Customer ID so the amounts added up our Per customer
-- * Customer C never became a member so is not included in the results 
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/de57d9c2-0775-4c53-9cc8-283354699041)

<br>

 **9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**
```sql
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
```
```
-- We use CASE to set up statements that WHEN the product is sushi each $1 is worth 2 Points
-- We use the ELSE statement to say in all other cases it is just worth the menu price
-- We wrap up the CASE statment by multiplying those points we just got by 10
-- The results are then added together with that first SUM() to become total_points
-- Join menu since you need it for product names to pick out which one is 'sushi' or not
-- Group by Customer so their total points are added up in the results
-- We take any customer out that is not a member by using HAVING COUNT of JOIN DATE not be 0
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/abba263a-1901-4293-8315-cbef2cae731a)

<br>

 **10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi
how many points do customer A and B have at the end of January?**
```sql
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
```
```
-- First we have to use a CTE to establish our CASE when we get points * 2
-- We save the 10x for the end of our case so we do it once and not for every calculation
-- We have to join all the existing Tables to Our CTE
-- We now have to draw the date we established and set up our results table
-- We use a subquery to select the start of the month and end of the month to count the correct orders
-- Group by Customer_id so all the points are added per customer
-- Again customer C never became a member so they are not included in the results
```
![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/553d30f7-8cea-4aa9-9493-988ae6623e94)

<br>
## Conclusion
- This case study demonstrates how to use common table expressions (CTEs) and JOIN clauses in SQL to combine data from multiple tables and perform calculations on the resulting data set.
- CTEs are useful for creating temporary result sets that can be used in a SELECT, INSERT, UPDATE, DELETE, or CREATE VIEW statement. They can help to simplify complex queries by breaking them down into smaller, more manageable pieces.
- The JOIN clause is used to combine rows from two or more tables based on a related column, such as customer_id or product_id. There are several types of JOIN clauses, including INNER JOIN, OUTER JOIN, LEFT JOIN, and RIGHT JOIN, each of which has its own syntax and behavior.
- In this case study, the CASE expression was used to apply different multipliers to the price of the items based on certain conditions, such as the product name or the order date. This can be a useful way to add conditional logic to a query and customize the results based on specific criteria.
-----

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a href="https://github.com/CameronCSS/SQL-Queries/blob/main/README.md"><strong>« Back to SQL Projects</strong></a>
<br>
<br>
<a href="https://github.com/CameronCSS/PersonalProjects/blob/main/README.md"><strong>« Back to Portfolio</strong></a>

## <a href="https://cameroncss.com/#contact">Contact Me</a>

  </table>
  <p style="margin-left: auto;">
    <a href="https://drive.google.com/file/d/1YaM4hDtt2-79ShBVTN06Y3BU79LvFw6J/view?usp=sharing" target="_blank" rel="noopener noreferrer">
      <img src="https://user-images.githubusercontent.com/121735588/215364205-abdfc0ac-53db-4733-8d43-b57c1bafb802.png" alt="Resume button">
    </a>
  </p>
</div>
