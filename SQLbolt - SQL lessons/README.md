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
