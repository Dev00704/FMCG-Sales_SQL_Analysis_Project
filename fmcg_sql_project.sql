-- Project: FMCG Sales SQL Analysis
-- Database Name: fmcg_sales_db

-- Tables and Relationships:
-- 1. Customers: Stores customer details (customer_id is the primary key)
-- 2. Products: Stores product details (product_id is the primary key)
-- 3. Sales: Records each sale (sale_id is the primary key)
--    - customer_id is a foreign key referencing Customers
--    - product_id is a foreign key referencing Products

-- Relationship Summary:
-- - One customer can make many sales
-- - One product can be sold in many sales
-- - Sales table links Customers and Products for meaningful joins

-- FMCG Sales SQL Project: 20 Real-World Queries 
-- Database: fmcg_sales_db

-- Q1: Show all customers' name, age, and city
SELECT name, age, city
FROM Customers;

-- Q2: Show product name, category, and price for all products
SELECT product_name, category, price
FROM Products;

-- Q3: Show all customers from Kolkata
SELECT *
FROM Customers
WHERE city = 'Kolkata';

-- Q4: Show all products with price greater than ₹50
SELECT product_name, category, price
FROM Products
WHERE price > 50;

-- Q5: Show all sales with quantity greater than 2
SELECT *
FROM Sales
WHERE quantity > 2;

-- Q6: Show product name, price, and total price for 3 units
SELECT product_name, price, (price * 3) AS total_price
FROM Products;

-- Q7: Show top 5 most expensive products
SELECT product_name, category, price
FROM Products
ORDER BY price DESC
LIMIT 5;

-- Q8: Show the 3 most recent sales by date
SELECT sale_id, customer_id, product_id, sale_date, quantity
FROM Sales
ORDER BY sale_date DESC
LIMIT 3;

-- Q9: Show total quantity sold across all sales
SELECT SUM(quantity) AS total_quantity_sold
FROM Sales;

-- Q10: Show average price of all products
SELECT AVG(price) AS average_price_of_all_products
FROM Products;

-- Q11: Show each product's total quantity sold
SELECT p.product_name, SUM(s.quantity) AS total_quantity_sold
FROM Products AS p
INNER JOIN Sales AS s ON p.product_id = s.product_id
GROUP BY p.product_name;

-- Q12: Show only those products with more than 3 units sold
SELECT p.product_name, SUM(s.quantity) AS total_quantity_sold
FROM Products AS p
INNER JOIN Sales AS s ON p.product_id = s.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity) > 3;

-- Q13: Show full sale records with customer and product names
SELECT 
    c.name AS customer_name,
    p.product_name,
    s.sale_id,
    s.customer_id,
    s.product_id,
    s.quantity
FROM Customers AS c
INNER JOIN Sales AS s ON c.customer_id = s.customer_id
INNER JOIN Products AS p ON s.product_id = p.product_id;

-- Q14: Show sales in the last 7 days
SELECT *
FROM Sales
WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- Q15: Show all customers whose names start with 'A'
SELECT customer_id, name, age, city
FROM Customers
WHERE name LIKE 'A%';

-- Q16: Classify customers into age groups
SELECT name, age, city,
  CASE 
    WHEN age < 25 THEN 'Young'
    WHEN age BETWEEN 25 AND 40 THEN 'Adult'
    WHEN age > 40 THEN 'Senior'
  END AS age_group
FROM Customers;

-- Q17: Label each sale as bulk or regular based on quantity
SELECT 
  p.product_name,
  s.sale_id,
  s.customer_id,
  s.product_id,
  s.sale_date,
  s.quantity,
  CASE 
    WHEN s.quantity > 3 THEN 'BULK_ORDER'
    ELSE 'REGULAR_ORDER'
  END AS sales_status
FROM Sales AS s
INNER JOIN Products AS p ON s.product_id = p.product_id;

-- Q18: Show top 3 customers by total quantity purchased
SELECT c.customer_id, c.name, SUM(s.quantity) AS highest_total_quantity
FROM Customers AS c
INNER JOIN Sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name
ORDER BY highest_total_quantity DESC
LIMIT 3;

-- Q19: Show products with ₹10 discount applied
SELECT product_name, price, (price - 10) AS discounted_price
FROM Products;

-- Q20: Show top-selling product overall
SELECT p.product_name, SUM(s.quantity) AS total_sold
FROM Products AS p
INNER JOIN Sales AS s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;
