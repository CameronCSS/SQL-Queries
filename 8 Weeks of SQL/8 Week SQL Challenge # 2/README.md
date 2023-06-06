<a name="readme-top"></a>

<a href="https://8weeksqlchallenge.com/case-study-2/" target="_blank"> LINK TO THE CHALLENGE </a>

```diff
- SPOILER -
- The following code contains the solutions to the challenge. 
- If you want to try solving it yourself, please visit the link before continuing.
```

## Introduction
Did you know that over 115 million kilograms of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

<div align="center">
<img src="https://github.com/CameronCSS/SQL-Queries/assets/121735588/7e5119cc-a94c-432b-8bfa-ab4d177b78dd" height="400">
	</div>

### Case Study Questions
This case study has LOTS of questions - they are broken up by area of focus including:

* Pizza Metrics
* Runner and Customer Experience
* Ingredient Optimisation
* Pricing and Ratings
* Bonus DML Challenges (DML = Data Manipulation Language)

Each of the following case study questions can be answered using a single SQL statement.

----

### Pizza Runner
#### *Starting SQL Script to establish the DB*
```sql
DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

```

## Relationship Diagram

![image](https://github.com/CameronCSS/SQL-Queries/assets/121735588/c7d62633-d8b1-4461-88e8-b899171b8f46)


<p align="right">(<a href="#readme-top">back to top</a>)</p>

----
## Questions

### A. Pizza Metrics
* How many pizzas were ordered?
* How many unique customer orders were made?
* How many successful orders were delivered by each runner?
* How many of each type of pizza was delivered?
* How many Vegetarian and Meatlovers were ordered by each customer?
* What was the maximum number of pizzas delivered in a single order?
* For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
* How many pizzas were delivered that had both exclusions and extras?
* What was the total volume of pizzas ordered for each hour of the day?
* What was the volume of orders for each day of the week?


### B. Runner and Customer Experience
* How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
* What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
* Is there any relationship between the number of pizzas and how long the order takes to prepare?
* What was the average distance travelled for each customer?
* What was the difference between the longest and shortest delivery times for all orders?
* What was the average speed for each runner for each delivery and do you notice any trend for these values?
* What is the successful delivery percentage for each runner?



### C. Ingredient Optimisation
* What are the standard ingredients for each pizza?
* What was the most commonly added extra?
* What was the most common exclusion?
* Generate an order item for each record in the customers_orders table in the format of one of the following:
  * Meat Lovers
  * Meat Lovers - Exclude Beef
  * Meat Lovers - Extra Bacon
  * Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
* Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
  * For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
* What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?



### D. Pricing and Ratings
* If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
* What if there was an additional $1 charge for any pizza extras?
  * Add cheese is $1 extra
* The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
* Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
  * customer_id
  * order_id
  * runner_id
  * rating
  * order_time
  * pickup_time
  * Time between order and pickup
  * Delivery duration
  * Average speed
  * Total number of pizzas
* If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?



### E. Bonus Questions
* If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?
  
<br>

----

## Answers

### A. Pizza Metrics

  **1. How many pizzas were ordered?**

```sql

```
```
-- Comments
```
![image]()
<br>

  **2. How many unique customer orders were made?**

```sql

```
```
-- Comments
```
![image]()
<br>
  **3. How many successful orders were delivered by each runner?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4. How many of each type of pizza was delivered?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **5. How many Vegetarian and Meatlovers were ordered by each customer?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **6. What was the maximum number of pizzas delivered in a single order?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **8. How many pizzas were delivered that had both exclusions and extras?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **9. What was the total volume of pizzas ordered for each hour of the day?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **10. What was the volume of orders for each day of the week?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
<br>
<br>

### B. Runner and Customer Experience

  **1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)**

```sql

```
```
-- Comments
```
![image]()
<br>

  **2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?**

```sql

```
```
-- Comments
```
![image]()
<br>
  **3. Is there any relationship between the number of pizzas and how long the order takes to prepare?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4. What was the average distance travelled for each customer?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **5. What was the difference between the longest and shortest delivery times for all orders?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **6. What was the average speed for each runner for each delivery and do you notice any trend for these values?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **7. What is the successful delivery percentage for each runner?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
<br>
<br>

### C. Ingredient Optimisation

  **1. What are the standard ingredients for each pizza?**

```sql

```
```
-- Comments
```
![image]()
<br>

  **2. What was the most commonly added extra?**

```sql

```
```
-- Comments
```
![image]()
<br>
  **3. What was the most common exclusion?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4. Generate an order item for each record in the customers_orders table in the format of one of the following:**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4a. Meat Lovers**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4b. Meat Lovers - Exclude Beef**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4c. Meat Lovers - Extra Bacon**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4d. Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients (For example: "Meat Lovers: 2xBacon, Beef, ... , Salami")**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
<br>
<br>

### D. Pricing and Ratings

  **1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?**

```sql

```
```
-- Comments
```
![image]()
<br>

  **2. What if there was an additional $1 charge for any pizza extras?**

```sql

```
```
-- Comments
```
![image]()
<br>
  **2a. Add cheese is $1 extra**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?**
  * customer_id
  * order_id
  * runner_id
  * rating
  * order_time
  * pickup_time
  * Time between order and pickup
  * Delivery duration
  * Average speed
  * Total number of pizzas
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
  **5a. how much money does Pizza Runner have left over after these deliveries?**
  
```sql

```
```
-- Comments
```
![image]()
<br>
<br>
<br>

### Bonus Questions

  **1. If Danny wants to expand his range of pizzas - how would this impact the existing data design?**

```sql

```
```
-- Comments
```
![image]()
<br>
  **1a. Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?**

```sql

```
```
-- Comments
```
![image]()
<br>

## Conclusion





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
