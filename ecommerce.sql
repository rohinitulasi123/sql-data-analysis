-- ecommerce.sql
-- 1. Create DB and tables
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(150),
  country VARCHAR(50)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  quantity INT,
  order_date DATE,
  revenue DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Insert sample data
INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com', 'USA'),
(2, 'Bob', 'bob@example.com', 'UK'),
(3, 'Charlie', NULL, 'India'),    -- NULL email to show null handling
(4, 'Diana', 'diana@example.com', 'India');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 800),
(102, 'Phone', 'Electronics', 500),
(103, 'Shoes', 'Fashion', 50),
(104, 'Watch', 'Accessories', 120);

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2025-08-01', 800),
(1002, 2, 103, 2, '2025-08-02', 100),
(1003, 3, 102, 1, '2025-08-03', 500),
(1004, 1, 103, 1, '2025-08-04', 50),
(1005, 4, 104, 3, '2025-07-31', 360);

-- 3. Basic SELECT, WHERE, ORDER BY, GROUP BY examples
-- a) List customers from India
SELECT * FROM customers WHERE country = 'India';

-- b) Total revenue per product (grouping & ordering)
SELECT p.product_id, p.name, SUM(o.revenue) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;

-- 4. Joins examples
-- INNER JOIN (full order details)
SELECT o.order_id, c.name AS customer, p.name AS product, o.quantity, o.revenue, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id;

-- LEFT JOIN (show customers and any orders)
SELECT c.customer_id, c.name, o.order_id, o.revenue
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- 5. Subquery example
-- Customers who spent more than 500 in total
SELECT name FROM customers
WHERE customer_id IN (
  SELECT customer_id FROM orders
  GROUP BY customer_id
  HAVING SUM(revenue) > 500
);

-- 6. WHERE vs HAVING illustration
-- WHERE cannot filter aggregated values; HAVING filters groups
-- Wrong (will error or not filter by aggregate): WHERE SUM(revenue) > 100
-- Right:
SELECT product_id, SUM(revenue) AS tot
FROM orders
GROUP BY product_id
HAVING SUM(revenue) > 100;

-- 7. Average revenue per user
-- Method A: total revenue / distinct users
SELECT ROUND(SUM(revenue) / COUNT(DISTINCT customer_id), 2) AS avg_revenue_per_user
FROM orders;

-- Method B: average of per-user totals (gives same here)
SELECT ROUND(AVG(total_spent), 2) AS avg_per_user
FROM (
  SELECT customer_id, SUM(revenue) AS total_spent
  FROM orders
  GROUP BY customer_id
) t;

-- 8. View creation
CREATE OR REPLACE VIEW top_spending_customers AS
SELECT customer_id, SUM(revenue) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;

-- 9. Index (optimization)
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- 10. Handling NULLs example
-- Replace NULL email with 'missing@example.com' for display
SELECT customer_id, name, COALESCE(email, 'missing@example.com') AS email_display
FROM customers;

-- 11. Example of subquery in SELECT (correlated)
SELECT c.customer_id, c.name,
  (SELECT SUM(revenue) FROM orders o WHERE o.customer_id = c.customer_id) AS total_spent
FROM customers c;
