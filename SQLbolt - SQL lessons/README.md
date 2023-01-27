# SQLbolt - SQL lessons

"To retrieve data from a SQL database, we need to write SELECT statements, which are often colloquially refered to as queries. A query in itself is just a statement which declares what data we are looking for, where to find it in the database, and optionally, how to transform it before it is returned. It has a specific syntax though, which is what we are going to learn in the following exercises." - SQLBolt

- <a href="https://sqlbolt.com/lesson/select_queries_introduction">Link to SQLbolt </a>

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

```
