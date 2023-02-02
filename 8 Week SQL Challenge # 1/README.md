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
SELECT customer_id, SUM(price) AS total_spent
  FROM sales
JOIN menu ON sales.product_id = menu.product_id
  GROUP BY customer_id;
```
```
-- This query will join the sales and menu tables on the product_id column
-- The SUM() function is used to calculate the total amount spent by each customer.
-- The resulting table will have two columns: customer_id and total_spent.
-- We group the results by customer_id.
```
![image](https://user-images.githubusercontent.com/121735588/211182320-c84a5f69-b2a5-4cde-8527-28e488fac34e.png)
<br>
  **2. How many days has each customer visited the restaurant?**

```sql
SELECT customer_id, COUNT(DISTINCT order_date) as days_visited
FROM sales
GROUP BY customer_id;
```
```
-- This Grabs the customer ID, and then counts the Distinct number of Orders they have
-- Two columns are created, customer ID, and Days_visited, to display our info
-- We group the count By Customer ID since we want to see how many total days each Customer visited
```
![image](https://user-images.githubusercontent.com/121735588/211182331-9a76fea7-5263-4638-b4e7-3496e037313b.png)
<br>
  **3. What was the first item from the menu purchased by each customer?**
  
```sql
SELECT sales.customer_id, menu.product_name, Order_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN (
  SELECT customer_id, MIN(order_date) AS first_order_date
  FROM sales
  GROUP BY customer_id
) FirstOrder ON sales.customer_id = FirstOrder.customer_id AND sales.order_date = FirstOrder.first_order_date;
```
```
-- We establish our main columns as customer id, and Product name, and order date
-- Then we have to join the sales and menu tables with their corresponding Key
-- Next we do a Self join creating a Temp Table called FirstOrder *(temp name goes after our inner select statement)*
-- In the Select statement of our temp table we are identifying their first order with MIN(order_date)
-- Creating this temp table saves us from having to use a self-join with multiple MIN function calls
```
![image](https://user-images.githubusercontent.com/121735588/211182493-4648bedc-5849-41af-82b4-1487401947f6.png)
<br>

 **4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
```sql
SELECT menu.product_name, COUNT(sales.product_id) as number_purchased
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY menu.product_name
ORDER BY number_purchased DESC;
 ```
 ```
 -- We establish our two data columns as Product name and Number purchased
 -- We use the function COUNT to count the number of products in our table
 -- We then join the Sales table and menu table using their Key 'Product.id'
 -- We then GROUP BY product, so our aggregate count function adds all those into one
 -- We then ORDER in descending order so we can see the most purchased item at the top of our list 
 ```
 ![image](https://user-images.githubusercontent.com/121735588/211182506-f2ea6c5f-15c1-4a31-8930-c33d0d301dff.png)
<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

 **5. Which item was the most popular for each customer?**
```sql
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
![image](https://user-images.githubusercontent.com/121735588/211182515-05efd346-6a6e-4419-93c3-db6f266ffe58.png)
<br>

 **6. Which item was purchased first by the customer after they became a member?**
```sql
SELECT sales.customer_id, menu.product_name, sales.order_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date > members.join_date;
```
```
-- Establish columns of data we want as ID, Product, and Order date
-- We then Join all three tables since we need information from each one
-- Remember to link using the correct KEY, in this case its cust_id = cust_id, and prod_id = prod_id
-- Then we simply use a WHERE statement to only show order_dates that were AFTER they joined as a Member
-- Notice customer C doesnt show up because they never became a Member
```
![image](https://user-images.githubusercontent.com/121735588/211182560-85554c08-70b2-41bf-99de-75ce3e6b9b71.png)
<br>
  
 **7. Which item was purchased just before the customer became a member?**
```sql
 SELECT sales.customer_id, menu.product_name, sales.order_date, members.join_date
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
ORDER BY sales.customer_id, sales.order_date DESC;
 ```
 ```
 -- First we establish our data columns, ID, Product, Order and Join dates
 -- Next we join all 3 tables with their KEYS
 -- We then use WHERE to filter the results where order dates were BEFORE they became a member
 -- You can order however you want here.
 -- I chose to order by customer and DESC date so we could easily see the customer and the order just before they became a member
 ```
 ![image](https://user-images.githubusercontent.com/121735588/211182770-9f922f53-3d15-427c-b8c4-f733846e982c.png)
<br>

 **8. What is the total items and amount spent for each member before they became a member?**
```sql
SELECT sales.customer_id, COUNT(sales.product_id) as number_items, SUM(menu.price) as amount_spent
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
GROUP BY sales.customer_id;
```
```
-- We establish our data columns
-- We use COUNT to add up the amount of products purchased
-- SUM(menu.price) is used to add up the total spent
-- We join all Tables through their common KEYS
-- We then use WHERE to filter the results so only orders BEFORE they joined are included
-- Finally we group by Customer ID so the amounts added up our Per customer
-- * Customer C never became a member so is not included in the results 
```
![image](https://user-images.githubusercontent.com/121735588/211183026-f4eec4b1-ae03-48a4-9bc0-38a470ee0c73.png)
<br>

 **9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**
```sql
SELECT sales.customer_id, 
  SUM((CASE 
    WHEN menu.product_name = 'sushi' THEN menu.price * 2 
	    ELSE menu.price END) * 10) AS total_points
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;
```
```
-- We use CASE to set up statements that WHEN the product is sushi each $1 is worth 2 Points
-- We use the ELSE statement to say in all other cases it is just worth the menu price
-- We wrap up the CASE statment by multiplying those points we just got by 10
-- The results are then added together with that first SUM() to become total_points
-- Join menu since you need it for product names to pick out which one is 'sushi' or not
-- Group by Customer so their total points are added up in the results
```
![image](https://user-images.githubusercontent.com/121735588/211183134-7d216b26-5bf7-4625-8a30-662ab7f1ad47.png)
<br>

 **10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi
how many points do customer A and B have at the end of January?**
```sql
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
```
```
-- First we have to use a CTE to establish our valid dates for the 2x points promotion
-- Next we have to calculate the fact that Sushi ALSO gives you 2x points
-- We set up the promo 2x points between the time they joined and a week later, referencing our CTE
-- We save the 10x for the end of our case so we do it once and not for every calculation
-- We have to join all the existing Tables to Our CTE
-- We now have to draw the date we established and set up our results table
-- We need to reference our first Dates CTE and have to join it again since we are joining two temp tables
-- We filter the resulting data so ONLY the orders before the end of the month are counted
-- Group by Customer_id so all the points are added per customer
-- Again customer C never became a member so they are not included in the results
```
![image](https://user-images.githubusercontent.com/121735588/211183881-a5f5fea0-6c6e-45b5-a4da-69bb5edb7794.png)
<br>
## Conclusion
- This case study demonstrates how to use common table expressions (CTEs) and JOIN clauses in SQL to combine data from multiple tables and perform calculations on the resulting data set.
- CTEs are useful for creating temporary result sets that can be used in a SELECT, INSERT, UPDATE, DELETE, or CREATE VIEW statement. They can help to simplify complex queries by breaking them down into smaller, more manageable pieces.
- The JOIN clause is used to combine rows from two or more tables based on a related column, such as customer_id or product_id. There are several types of JOIN clauses, including INNER JOIN, OUTER JOIN, LEFT JOIN, and RIGHT JOIN, each of which has its own syntax and behavior.
- In this case study, the CASE expression was used to apply different multipliers to the price of the items based on certain conditions, such as the product name or the order date. This can be a useful way to add conditional logic to a query and customize the results based on specific criteria.
-----

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a href="https://github.com/CameronCSS/PersonalProjects/blob/main/README.md"><strong>« Back to Portfolio</strong></a>

## Contact Me

<div style="display: flex;">
  <table style="flex: 1;">
  
||
| --- |
| :e-mail: :heavy_minus_sign: CameronSeamons@gmail.com |
| <a href="https://www.linkedin.com/in/cameron-css/">![linkedin](https://user-images.githubusercontent.com/121735588/215363352-ad51a5e1-0de8-48be-8ceb-28c610e5d34d.png)</a> :heavy_minus_sign: https://www.linkedin.com/in/cameron-css/|
| <a href="https://twitter.com/Cameron_CSS">![twitter logo](https://user-images.githubusercontent.com/121735588/215363444-e4b080b6-e122-49cb-8b41-601dab6e10eb.png)</a> :heavy_minus_sign: https://twitter.com/Cameron_CSS |

  </table>
  <p style="margin-left: auto;">
    <a href="https://drive.google.com/file/d/19vkbf2HjEpXpxndWYa4A6Dyt6gsnGv73/view?usp=sharing" target="_blank" rel="noopener noreferrer">
      <img src="https://user-images.githubusercontent.com/121735588/215364205-abdfc0ac-53db-4733-8d43-b57c1bafb802.png" alt="Resume button">
    </a>
  </p>
</div>
