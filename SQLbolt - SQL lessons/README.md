# SQLbolt - SQL Queries

This collection of SQL queries was learned and compiled from [SQLbolt](https://sqlbolt.com/), a website that provides interactive tutorials to help users learn SQL (Structured Query Language) and improve their skills.

The queries included in this code showcase the various capabilities of SQL and demonstrate how to use it to retrieve and manipulate data. They cover a wide range of topics, including:

- SELECT statements
- Filtering and sorting data
- Joining tables
- Creating and modifying databases and tables


---

### SQL Lesson 1: SELECT queries 101

```sql
--Find the title of each film
SELECT title FROM movies;
```
```sql
--Find the director of each film
SELECT director FROM movies;
```
```sql
--Find the title and director of each film
SELECT title, director FROM movies;
```
```sql
--Find the title and year of each film
SELECT title, year FROM movies;
```
```sql
--Find all the information about each film
SELECT * FROM movies;
```
### SQL Lesson 2: Queries with constraints (Pt. 1)

```sql
--Find the movie with a row id of 6
SELECT title FROM movies
WHERE id = 6;
```
```sql
-Find the movies released in the years between 2000 and 2010
SELECT title FROM movies
WHERE year BETWEEN 2000 AND 2010;
```
```sql
--Find the movies not released in the years between 2000 and 2010
SELECT title FROM movies
WHERE year NOT BETWEEN 2000 AND 2010;
```
```sql
--Find the first 5 Pixar movies and their release year
SELECT title, year FROM movies
ORDER BY year ASC LIMIT 5;
```

### SQL Lesson 3: Queries with constraints (Pt. 2)

```sql
-- Find all the Toy Story movies
SELECT * FROM movies
WHERE title LIKE '%Toy Story%';
```
```sql
-- Find all the movies directed by John Lasseter
SELECT * FROM movies
WHERE director = 'John Lasseter';
```
```sql
-- Find all the movies (and director) not directed by John Lasseter
SELECT * FROM movies
WHERE director <> 'John Lasseter';
```
```sql
-- Find all the WALL-* movies
SELECT * FROM movies
WHERE title LIKE '%Wall-%';
```

### SQL Lesson 4: Filtering and sorting Query results

```sql
-- List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT(director) FROM movies
ORDER BY director;
```
```sql
-- List the last four Pixar movies released (ordered from most recent to least)
SELECT title FROM movies
ORDER BY year DESC LIMIT 4;
```
```sql
-- List the first five Pixar movies sorted alphabetically
SELECT title FROM movies
ORDER BY title ASC LIMIT 5;
```
```sql
-- List the first five Pixar movies sorted alphabetically
SELECT title FROM movies
ORDER BY title ASC LIMIT 5
OFFSET 5;
```

### SQL Lesson 5: Simple SELECT Queries

```sql
-- List all the Canadian cities and their populations
SELECT city, population FROM north_american_cities
WHERE country = 'Canada';
```
```sql
-- Order all the cities in the United States by their latitude from north to south
SELECT city FROM north_american_cities
WHERE country = 'United States'
ORDER BY latitude DESC;
```
```sql
-- List all the cities west of Chicago, ordered from west to east
SELECT city FROM north_american_cities
WHERE Longitude < (SELECT Longitude FROM north_american_cities WHERE City = 'Chicago')
ORDER BY Longitude ASC;
```
```sql
-- List the two largest cities in Mexico (by population)
SELECT city FROM north_american_cities
WHERE country = 'Mexico'
ORDER BY population DESC LIMIT 2;
```
```sql
-- List the third and fourth largest cities (by population) in the United States and their population
SELECT city FROM north_american_cities
WHERE country = 'United States'
ORDER BY population DESC LIMIT 2
OFFSET 2;
```
### SQL Lesson 6: Multi-table queries with JOINs

```sql
-- Find the domestic and international sales for each movie
SELECT movies.title, boxoffice.domestic_sales, boxoffice.international_sales
FROM movies
JOIN boxoffice
ON movies.id = boxoffice.Movie_id;
```
```sql
-- Show the sales numbers for each movie that did better internationally rather than domestically
SELECT movies.title, boxoffice.domestic_sales, boxoffice.international_sales
FROM movies
JOIN boxoffice
ON movies.id = boxoffice.Movie_id
WHERE boxoffice.international_sales > boxoffice.domestic_sales;
```
```sql
-- List all the movies by their ratings in descending order 
SELECT movies.title, boxoffice.rating
FROM movies
JOIN boxoffice
ON movies.id = boxoffice.Movie_id
ORDER BY boxoffice.rating DESC;
```

### SQL Lesson 7: OUTER JOINs

```sql
-- Find the list of all buildings that have employees
SELECT employees.building 
FROM employees
LEFT OUTER JOIN buildings
ON employees.building = buildings.building_name
GROUP BY buildings.building_name;
```
```sql
-- Find the list of all buildings and their capacity
SELECT * 
FROM buildings;
```
```sql
-- List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT(buildings.building_name), employees.role
FROM buildings
LEFT OUTER JOIN employees
ON buildings.building_name = employees.building;
```

### SQL Lesson 8: A short note on NULLs

```sql
-- Find the name and role of all employees who have not been assigned to a building
SELECT name, role 
FROM employees
WHERE building IS NULL;
```
```sql
-- Find the names of the buildings that hold no employees
SELECT buildings.building_name
FROM buildings
LEFT OUTER JOIN employees
ON buildings.building_name = employees.building
WHERE employees.building IS NULL;
```

### SQL Lesson 9: Queries with expressions

```sql
-- List all movies and their combined sales in millions of dollars
SELECT movies.title, (boxoffice.domestic_sales + boxoffice.international_sales) / 1000000 AS combined_sales_millions
FROM movies
JOIN boxoffice
ON movies.id = boxoffice.movie_id;
```
```sql
-- List all movies and their ratings in percent
SELECT movies.title, (boxoffice.rating * 10) as rating_percent
FROM movies
JOIN boxoffice
ON movies.id = boxoffice.movie_id;
```
```sql
-- List all movies that were released on even number years
SELECT title, year FROM movies
WHERE (year % 2) = 0;
```

### SQL Lesson 10: Queries with aggregates (Pt. 1)

```sql
-- Find the longest time that an employee has been at the studio
SELECT name, MAX(years_employed)
FROM employees;
```
```sql
-- For each role, find the average number of years employed by employees in that role
SELECT DISTINCT(role), AVG(years_employed)
FROM employees
GROUP BY role;
```
```sql
-- Find the total number of employee years worked in each building
SELECT building, SUM(years_employed)
FROM employees
GROUP BY building;
```

### SQL Lesson 11: Queries with aggregates (Pt. 2)

```sql
-- Find the number of Artists in the studio (without a HAVING clause)
SELECT COUNT(role) FROM employees
WHERE role = 'Artist';
```
```sql
-- Find the number of Employees of each role in the studio
SELECT role, COUNT(role) FROM employees
GROUP BY role;
```
```sql
-- Find the total number of years employed by all Engineers
SELECT role, SUM(years_employed) 
FROM employees
WHERE role = 'Engineer'
```

### SQL Lesson 12: Order of execution of a Query

```sql
-- Find the number of movies each director has directed
SELECT COUNT(title), director
FROM movies
GROUP BY director;
```
```sql
SELECT movies.director, SUM(boxoffice.domestic_sales + boxoffice.	international_sales) AS total_sales
FROM movies
LEFT OUTER JOIN boxoffice
ON movies.id = boxoffice.movie_id
GROUP BY director;
```

### SQL Lesson 13: Inserting rows

```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```
```sql

```

