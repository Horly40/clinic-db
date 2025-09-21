SELECT p.productName, p.productVendor, p.productLine
FROM products AS p
LEFT JOIN productlines AS pl
ON p.productLine = pl.productLine
ORDER BY p.productName;

SELECT e.firstName, e.lastName, e.email, e.officeCode
FROM employees AS e
INNER JOIN offices AS o
ON e.officeCode = o.officeCode
ORDER BY e.lastName, e.firstName;

SELECT o.orderDate, o.shippedDate, o.status, o.customerNumber
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customerNumber = o.customerNumber
ORDER BY o.orderDate ASC
LIMIT 10;

CREATE TABLE IF NOT EXISTS ProductOrders (
  OrderID INT NOT NULL,
  CustomerName VARCHAR(100),
  Product VARCHAR(255),
  PRIMARY KEY (OrderID, Product) -- composite key to avoid duplicates
);

-- Create the ProductDetail table
CREATE TABLE ProductDetail (
  OrderID INT,
  CustomerName VARCHAR(100),
  Products VARCHAR(255)
);

-- Insert the sample data from the assignment
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');



INSERT INTO ProductOrders (OrderID, CustomerName, Product)
SELECT
  pd.OrderID,
  pd.CustomerName,
  TRIM(jt.product) AS Product
FROM ProductDetail AS pd
JOIN JSON_TABLE(
  CONCAT('["', REPLACE(pd.Products, ',', '","'), '"]'),
  '$[*]' COLUMNS (product VARCHAR(255) PATH '$')
) AS jt;

SELECT * FROM ProductOrders ORDER BY OrderID, Product;

-- Create Orders (header) table
CREATE TABLE IF NOT EXISTS Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS OrderItems (   
   orderNumber INT,   
   Product VARCHAR(255),   
   Quantity INT,   
   PRIMARY KEY (orderNumber, Product),   
   FOREIGN KEY (orderNumber) REFERENCES Orders(orderNumber) 
);

CREATE TABLE OrderDetails_Assignment (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Quantity INT
);
DROP TABLE IF EXISTS OrderDetails;

CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Quantity INT
);
-- Drop if exists to avoid clashes
DROP TABLE IF EXISTS ProductDetail_Assignment;

-- Original unnormalized table
CREATE TABLE ProductDetail_Assignment (
    OrderID INT,
    CustomerName VARCHAR(255),
    Products VARCHAR(255)
);

-- Insert sample data
INSERT INTO ProductDetail_Assignment (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Transform into 1NF: each product gets its own row
DROP TABLE IF EXISTS ProductOrders_Assignment;

CREATE TABLE ProductOrders_Assignment (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

INSERT INTO ProductOrders_Assignment (OrderID, CustomerName, Product)
SELECT 
    pd.OrderID,
    pd.CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', numbers.n), ',', -1)) AS Product
FROM ProductDetail_Assignment pd
JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3
) numbers
ON CHAR_LENGTH(pd.Products) - CHAR_LENGTH(REPLACE(pd.Products, ',', '')) >= numbers.n - 1;

-- Drop if exists
DROP TABLE IF EXISTS OrderDetails_Assignment;

-- Original 1NF version
CREATE TABLE OrderDetails_Assignment (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Quantity INT
);

-- Insert data
INSERT INTO OrderDetails_Assignment (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Create Orders_Assignment (CustomerName depends only on OrderID)
DROP TABLE IF EXISTS Orders_Assignment;

CREATE TABLE Orders_Assignment (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

INSERT INTO Orders_Assignment (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails_Assignment;

-- Create OrderItems_Assignment (Product depends on both OrderID + Quantity)
DROP TABLE IF EXISTS OrderItems_Assignment;

CREATE TABLE OrderItems_Assignment (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_Assignment(OrderID)
);

INSERT INTO OrderItems_Assignment (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails_Assignment;
