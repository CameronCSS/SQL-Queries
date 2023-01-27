# Generic SQL 
 - language: SQL 

SELECT author, SUM(words) AS total_words 
FROM books 
GROUP BY author HAVING total_words > 1000000;

SELECT author, AVG(words) AS avg_words 
FROM books
GROUP BY author HAVING avg_words > 150000;

SELECT name, number_grade, ROUND(fraction_completed * 100) AS percent_completed 
FROM student_grades;

SELECT COUNT(*) AS count,
CASE 
    WHEN number_grade > 90 THEN "A"
    
    WHEN number_grade > 80 THEN "B"
    
    WHEN number_grade > 70 THEN "C"
    
  ELSE "F"
  END AS letter_grade
FROM student_grades
GROUP BY letter_grade;

INSERT INTO persons (name, age) VALUES ("NEW GUY", 23);
INSERT INTO hobbies (person_id, name) VALUES (6, "beatbox");

SELECT persons.name, hobbies.name 
FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id;

SELECT persons.name, hobbies.name FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id
WHERE persons.name = 'Bobby McBobbyFace';

SELECT customers.name, customers.email, orders.item, orders.price FROM customers
LEFT OUTER JOIN orders
ON orders.customer_id = customers.id ;

SELECT customers.name, customers.email, SUM(orders.price) AS total_spent
FROM customers
LEFT OUTER JOIN orders
ON orders.customer_id = customers.id
GROUP BY customers.id
ORDER BY total_spent DESC;

SELECT movies.title, sequel.title AS sequel
FROM movies
LEFT OUTER JOIN movies sequel
ON movies.sequel_id = sequel.id;

UPDATE documents SET author = "Jackie Draper" 
WHERE author = "Jackie Paper";


SELECT * FROM documents;

DELETE FROM documents WHERE title = "Things I'm Afraid Of";

SELECT * FROM documents;

SELECT persons.fullname, hobbies.name
FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id;

SELECT a.fullname, b.fullname 
FROM friends
JOIN persons a
ON friends.person1_id = a.id
JOIN persons b
ON friends.person2_id = b.id;
