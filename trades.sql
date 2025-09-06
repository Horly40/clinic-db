USE trades;
CREATE TABLE customers (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    signup_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers (name, email, phone, address, date_of_birth)
VALUE
 ('John', 'John@gmail.com', '+247081461234', 'Nigeria', '1997-08-31');
 
 INSERT INTO customers (name, email, phone, address, date_of_birth)
VALUE
 ('Doe', 'Doe@gmail.com', '+2247081461234', 'ghana', '1997-08-31');
 
 INSERT INTO customers (name, email, phone, address, date_of_birth)
VALUE
 ('Wills', 'Wilson@gmail.com', '+2547081461234', 'k', '1997-08-31');


