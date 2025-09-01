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
