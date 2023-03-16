CREATE DATABASE pizza_sales;

USE pizza_sales;

CREATE TABLE order_details (
    order_details_id INT,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT
);

BULK INSERT order_details
FROM 'order_details.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE orders (
    order_id INT,
    date DATE,
    time DATETIME
);

BULK INSERT orders
FROM 'orders.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50),
    name VARCHAR(50),
    category VARCHAR(50),
	ingredients VARCHAR(100)
);

BULK INSERT pizza_types
FROM 'pizza_types.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE pizzas (
    pizza_id VARCHAR(50),
    pizza_type_id VARCHAR(50),
    size VARCHAR(50),
	price FLOAT
);

BULK INSERT pizzas
FROM 'pizzas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT TOP 5 * FROM pizzas;

