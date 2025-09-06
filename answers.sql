USE salesdb;
SELECT checkNumber, paymentDate, amount
FROM payments;

-- 2️⃣ Retrieve orderDate, requiredDate, and status of orders 'In Process', sorted by orderDate descending
SELECT orderDate, requiredDate, status
FROM orders
WHERE status = 'In Process'
ORDER BY orderDate DESC;

-- 3️⃣ Display firstName, lastName, and email of employees with jobTitle 'Sales Rep', ordered by employeeNumber descending
SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;

-- 4️⃣ Retrieve all columns and records from the offices table
SELECT *
FROM offices;

-- 5️⃣ Fetch productName and quantityInStock from products table, sorted by buyPrice ascending, limit 5 records
SELECT productName, quantityInStock
FROM products
ORDER BY buyPrice ASC
LIMIT 5;


-- Question 1: Create the student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    fullName VARCHAR(100),
    age INT
);

-- Question 2: Insert at least 3 records
INSERT INTO student (id, fullName, age) VALUES
(1, 'Alice Johnson', 19),
(2, 'Bob Smith', 18),
(3, 'Charlie Brown', 21);

-- Question 3: Update the age of the student with ID 2
UPDATE student
SET age = 20
WHERE id = 2;


-- Question 1: Total payment amount per payment date (top 5 latest)
SELECT paymentDate, SUM(amount) AS total_amount
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate DESC
LIMIT 5;

-- Question 2: Average credit limit per customer
SELECT customerName, country, AVG(creditLimit) AS avg_credit_limit
FROM customers
GROUP BY customerName, country;

-- Question 3: Total price of products ordered
SELECT productCode, quantityOrdered, SUM(quantityOrdered * priceEach) AS total_price
FROM orderdetails
GROUP BY productCode, quantityOrdered;

-- Question 4: Highest payment amount per check number
SELECT checkNumber, MAX(amount) AS highest_amount
FROM payments
GROUP BY checkNumber;

ALTER TABLE customers
ADD INDEX IdxPhone (phone);

CREATE USER 'bob'@'localhost' IDENTIFIED BY 'S$cu3r3!';
GRANT INSERT ON salesDB.* TO 'bob'@'localhost';
ALTER USER 'bob'@'localhost' IDENTIFIED BY 'P$55!23';
ALTER USER 'bob'@'localhost' IDENTIFIED BY 'P$55!23';

DROP INDEX IdxPhone ON customers;







