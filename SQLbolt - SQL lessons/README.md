<a name="readme-top"></a>

# SQLbolt - SQL Queries

This collection of SQL queries was learned from [SQLbolt](https://sqlbolt.com/), a website that provides interactive tutorials to help users learn SQL (Structured Query Language) and improve their skills.

The queries included in this code showcase the various capabilities of SQL and demonstrate how to use it to retrieve and manipulate data. They cover a wide range of topics, including:

- SELECT statements
- Filtering and sorting data
- Joining tables
- Creating and modifying databases and tables


---

### SQL Lesson 1: SELECT queries 101

```sql
-- Find the title of each film
SELECT title FROM movies;
```
```sql
-- Find the director of each film
SELECT director FROM movies;
```
```sql
-- Find the title and director of each film
SELECT title, director FROM movies;
```
```sql
-- Find the title and year of each film
SELECT title, year FROM movies;
```
```sql
-- Find all the information about each film
SELECT * FROM movies;
```
### SQL Lesson 2: Queries with constraints (Pt. 1)

```sql
-- Find the movie with a row id of 6
SELECT title FROM movies
WHERE id = 6;
```
```sql
-- Find the movies released in the years between 2000 and 2010
SELECT title FROM movies
WHERE year BETWEEN 2000 AND 2010;
```
```sql
-- Find the movies not released in the years between 2000 and 2010
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

<p align="right">(<a href="#readme-top">back to top</a>)</p>

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

<p align="right">(<a href="#readme-top">back to top</a>)</p>

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
-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
INSERT INTO movies 
(title, director, year, length_minutes)
VALUES ('Toy Story 4', 'Josh Cooley', 2019, 100);
SELECT * FROM movies;
```
```sql
-- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. 
-- Add the record to the BoxOffice table.
INSERT INTO boxoffice 
(movie_id, rating, domestic_sales, international_sales)
VALUES (15, 8.7, 340000000, 270000000);
SELECT * FROM boxoffice;
```

### SQL Lesson 14: Updating rows

```sql
-- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
UPDATE movies
SET director = 'John Lasseter'
WHERE title = 'A Bug''s Life';
SELECT * FROM movies;
```
```sql
-- The year that Toy Story 2 was released is incorrect, it was actually released in 1999
UPDATE movies
SET year = 1999
WHERE title = 'Toy Story 2';
SELECT * FROM movies;
```
```sql
-- Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
UPDATE movies
SET title = 'Toy Story 3',
    director = 'Lee Unkrich'
WHERE title = 'Toy Story 8';
SELECT * FROM movies;
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### SQL Lesson 15: Deleting rows

```sql
-- This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM movies
WHERE year < 2005;
SELECT * FROM movies;
```
```sql
-- Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE FROM movies
WHERE director = 'Andrew Stanton';
SELECT * FROM movies;
```

### SQL Lesson 16: Creating tables

```sql
-- Create a new table named Database with the following columns:
-- 1. Name A string (text) describing the name of the database
-- 2. Version A number (floating point) of the latest version of this database
-- 3. Download_count An integer count of the number of times this database was downloaded
-- This table has no constraints.

CREATE TABLE Database (
    Name TEXT,
    Version FLOAT,
    Download_Count INTEGER);
SELECT * FROM database;
```

### SQL Lesson 17: Altering tables

```sql
-- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
ALTER TABLE Movies
  ADD COLUMN Aspect_ratio FLOAT DEFAULT 3;
SELECT * FROM movies;
```
```sql
-- Add another column named Language with a TEXT data type to store the language that the movie was released in. 
-- Ensure that the default for this language is English.
ALTER TABLE Movies
  ADD COLUMN Language TEXT DEFAULT 'English';
SELECT * FROM movies;
```

### SQL Lesson 18: Dropping tables

```sql
-- We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE IF EXISTS movies;
```
```sql
-- And drop the BoxOffice table as well
DROP TABLE IF EXISTS boxoffice;
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### <a href="https://github.com/CameronCSS/PersonalProjects/blob/main/README.md">BACK TO PORTFOLIO</a>

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
