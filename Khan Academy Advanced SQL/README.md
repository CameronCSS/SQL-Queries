# Khan Academy: Advanced SQL Queries - Challenges

#### Queries begin with basic concepts and progress to more complex topics as we progress.
##### _*Feel free to scroll to the bottom for the most advanced queries from this course_

---

#### CHALLENGE: The wordiest author Part 1
```
--Select all the authors who have written more than 1 million words, using GROUP BY and HAVING. 
--Your results table should include the 'author' and their total word count as a 'total_words' column.
```

#### Answer: The wordiest author Part 1
```sql
SELECT author, SUM(words) AS total_words 
FROM books 
GROUP BY author HAVING total_words > 1000000;
```

#### CHALLENGE: The wordiest author Part 2
```
--Now select all the authors that write more than an average of 150,000 words per book. 
--Your results table should include the 'author' and average words as an 'avg_words' column.
```

#### Answer: The wordiest author Part 2
```sql
SELECT author, AVG(words) AS avg_words 
FROM books
GROUP BY author HAVING avg_words > 150000;
```
---

#### CHALLENGE: Gradebook Part 1
```
--We've created a database to track student grades, with their name, number grade, and what percent of activities they've completed.
--In this first step, select all of the rows, and display the name, number_grade, and percent_completed, 
which you can compute by multiplying and rounding the fraction_completed column.
```

#### Answer: Gradebook Part 1
```sql
SELECT name, number_grade, ROUND(fraction_completed * 100) AS percent_completed 
FROM student_grades;
```

#### CHALLENGE: Gradebook Part 2
```
--Now, this step is a little tricky. The goal is a table that shows how many students have earned which letter_grade. 
--You can output the letter_grade by using CASE with the number_grade column, 
outputting 'A' for grades > 90, 'B' for grades > 80, 'C' for grades > 70, and 'F' otherwise. 
--Then you can use COUNT with GROUP BY to show the number of students with each of those grades.
```

#### Answer: Gradebook Part 2
```sql
SELECT COUNT(*) AS count,
CASE 
    WHEN number_grade > 90 THEN "A"
    
    WHEN number_grade > 80 THEN "B"
    
    WHEN number_grade > 70 THEN "C"
    
  ELSE "F"
  END AS letter_grade
FROM student_grades
GROUP BY letter_grade;
```
---

#### CHALLENGE: Bobby's Hobbies Part 1
```
--We've created a database of people and hobbies, and each row in hobbies is related to a row in persons via the person_id column. 
--In this first step, insert one more row in persons and then one more row in hobbies that is related to the newly inserted person.
```

#### Answer: Bobby's Hobbies Part 1
```sql
INSERT INTO persons (name, age) VALUES ("NEW GUY", 23);
INSERT INTO hobbies (person_id, name) VALUES (6, "beatbox");
```

#### CHALLENGE: Bobby's Hobbies Part 2
```
--Now, select the 2 tables with a join so that you can see each person's name next to their hobby.
```

#### Answer: Bobby's Hobbies Part 2
```sql
SELECT persons.name, hobbies.name 
FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id;
```

#### CHALLENGE: Bobby's Hobbies Part 3
```
--Now, add an additional query that shows only the name and hobbies of 'Bobby McBobbyFace', using JOIN combined with WHERE.
```

#### Answer: Bobby's Hobbies Part 3
```sql
SELECT persons.name, hobbies.name FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id
WHERE persons.name = 'Bobby McBobbyFace';
```
---

#### CHALLENGE: Customer's orders Part 1
```
--We've created a database for customers and their orders. Not all of the customers have made orders, however. 
--Come up with a query that lists the name and email of every customer followed by the item and price of orders they've made. 
--Use a LEFT OUTER JOIN so that a customer is listed even if they've made no orders, and don't add any ORDER BY.
```

#### Answer: Customer's orders Part 1
```sql
SELECT customers.name, customers.email, orders.item, orders.price FROM customers
LEFT OUTER JOIN orders
ON orders.customer_id = customers.id ;
```

#### CHALLENGE: Customer's orders Part 2
```
--Now, create another query that will result in one row per each customer, 
with their name, email, and total amount of money they've spent on orders.
--Sort the rows according to the total money spent, from the most spent to the least spent.
(Tip: You should always GROUP BY on the column that is most likely to be unique in a row.)
```

#### Answer: Customer's orders Part 2
```sql
SELECT customers.name, customers.email, SUM(orders.price) AS total_spent
FROM customers
LEFT OUTER JOIN orders
ON orders.customer_id = customers.id
GROUP BY customers.id
ORDER BY total_spent DESC;
```
---

#### CHALLENGE: Sequels in SQL Part 1
```
--We've created a table with all the 'Harry Potter' movies, with a sequel_id column that matches the id of the sequel for each movie.
--Issue a SELECT that will show the title of each movie next to its sequel's title (or NULL if it doesn't have a sequel).
```

#### Answer: Sequels in SQL Part 1
```sql
SELECT movies.title, sequel.title AS sequel
FROM movies
LEFT OUTER JOIN movies sequel
ON movies.sequel_id = sequel.id;
```
---
#### CHALLENGE: Dynamic Documents Part 1
```
--In this first step, use UPDATE to change the author to 'Jackie Draper' for all rows where it's currently 'Jackie Paper'. 
--Then re-select all the rows to make sure the table changed like you expected.
```

#### Answer: Dynamic Documents Part 1
```sql
UPDATE documents SET author = "Jackie Draper" 
WHERE author = "Jackie Paper";


SELECT * FROM documents;
```

#### CHALLENGE: Dynamic Documents Part 2
```
--Now you'll delete a row, being very careful not to delete all the rows. 
--Only delete the row where the title is 'Things I'm Afraid Of'. 
--Then re-select all the rows to make sure the table changed like you expected.
```

#### Answer: Dynamic Documents Part 2
```sql
DELETE FROM documents WHERE title = "Things I'm Afraid Of";

SELECT * FROM documents;
```
---

#### CHALLENGE: FriendBook Part 1
```
--We've created a database for a friend networking site, with a table storing data on each person, a table on each person's hobbies, 
and a table of friend connections between the people. In this first step, use a JOIN to display a table showing people's names with their hobbies.
```

#### Answer: FriendBook Part 1
```sql
SELECT persons.fullname, hobbies.name
FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id;
```

#### CHALLENGE: FriendBook Part 2
```
--Now, use another SELECT with a JOIN to show the names of each pair of friends, based on the data in the friends table.
```

#### Answer: FriendBook Part 2
```sql
SELECT a.fullname, b.fullname 
FROM friends
JOIN persons a
ON friends.person1_id = a.id
JOIN persons b
ON friends.person2_id = b.id;
```

----

### <a href="https://github.com/CameronCSS/PersonalProjects">BACK TO INDEX</a>

## Contact Me

| Contact Method | Link |
| --- | --- |
| Email | CameronSeamons@gmail.com |
| LinkedIn | https://www.linkedin.com/in/cameron-css/|
| Twitter | https://twitter.com/Cameron_CSS |
| Resume | ['Cameron Seamons' Resume](https://drive.google.com/file/d/19vkbf2HjEpXpxndWYa4A6Dyt6gsnGv73/view?usp=sharing) | 


