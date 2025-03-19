-- Create the database
CREATE DATABASE bank_management;
USE bank_management;

-- Customers Table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Addresses Table (One-to-Many Relationship with Customers)
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100) NOT NULL,
    type ENUM('Home', 'Work', 'Other') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Credit Cards Table (One-to-Many Relationship with Customers)
CREATE TABLE credit_cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    card_number VARCHAR(16) UNIQUE NOT NULL,
    card_type ENUM('Visa', 'MasterCard', 'Amex') NOT NULL,
    cvv VARCHAR(4) NOT NULL,
    expiry_date DATE NOT NULL,
    credit_limit DECIMAL(10,2) NOT NULL,
    available_balance DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Insert Sample Data
INSERT INTO customers (first_name, last_name, email, phone, date_of_birth)
VALUES 
    ('John', 'Doe', 'johndoe@email.com', '1234567890', '1985-05-12'),
    ('Jane', 'Smith', 'janesmith@email.com', '9876543210', '1990-08-25');

INSERT INTO addresses (customer_id, street, city, state, zip_code, country, type)
VALUES 
    (1, '123 Main St', 'New York', 'NY', '10001', 'USA', 'Home'),
    (1, '456 Work Ave', 'New York', 'NY', '10002', 'USA', 'Work'),
    (2, '789 Elm St', 'Los Angeles', 'CA', '90001', 'USA', 'Home');

INSERT INTO credit_cards (customer_id, card_number, card_type, cvv, expiry_date, credit_limit, available_balance)
VALUES 
    (1, '4111111111111111', 'Visa', '123', '2027-12-01', 5000.00, 2500.00),
    (1, '5500000000000004', 'MasterCard', '456', '2026-10-15', 7000.00, 3500.00),
    (2, '340000000000009', 'Amex', '789', '2028-07-20', 6000.00, 4000.00);

-- Fetch customers with their addresses
SELECT c.id, c.first_name, c.last_name, a.street, a.city, a.state, a.zip_code, a.country, a.type
FROM customers c
LEFT JOIN addresses a ON c.id = a.customer_id;

-- Fetch customers with their credit cards
SELECT c.id, c.first_name, c.last_name, cc.card_number, cc.card_type, cc.expiry_date, cc.credit_limit, cc.available_balance
FROM customers c
LEFT JOIN credit_cards cc ON c.id = cc.customer_id;
