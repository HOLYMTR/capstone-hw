CREATE TABLE IF NOT EXISTS Salesman(
    Salesman_id TEXT PRIMARY KEY,
    name TEXT,
    city TEXT,
    Commission TEXT
);

INSERT OR IGNORE INTO Salesman(Salesman_id, name, city, Commission) VALUES
('5001', 'Rafiq Ahmed', 'Dhaka', '0.15'),
('5002', 'Shamima Khatun', 'Chittagong', '0.13'),
('5005', 'Kamal Hossain', 'Sylhet', '0.11'),
('5006', 'Nasrin Akter', 'Rajshahi', '0.14'),
('5007', 'Shahidul Islam', 'Khulna', '0.13'),
('5003', 'Taslima Begum', 'Barisal', '0.12');

CREATE TABLE IF NOT EXISTS Customer(
    customer_id TEXT PRIMARY KEY,
    cust_name TEXT,
    city TEXT,
    grade TEXT,
    Salesman_id TEXT
);

INSERT OR IGNORE INTO Customer(customer_id, cust_name, city, grade, Salesman_id) VALUES
('3002', 'Abdur Rahim', 'Dhaka', '100', '5001'),
('3007', 'Fatema Begum', 'Gazipur', '200', '5001'),
('3005', 'Mizanur Rahman', 'Narayanganj', '200', '5002'),
('3008', 'Shahana Akhter', 'Chittagong', '300', '5002'),
('3004', 'Abul Hashem', 'Coxs Bazar', '300', '5006'),
('3009', 'Parvin Sultana', 'Mymensingh', '100', '5003'),
('3003', 'Jahangir Alam', 'Comilla', '200', '5007'),
('3001', 'Rokeya Begum', 'Sylhet', '', '5005');

CREATE TABLE IF NOT EXISTS Orders(
    ord_no TEXT PRIMARY KEY,
    purch_amt TEXT,
    ord_date TEXT,
    customer_id TEXT,
    Salesman_id TEXT
);

INSERT OR IGNORE INTO Orders(ord_no, purch_amt, ord_date, customer_id, Salesman_id) VALUES
('70001', '150.5', '2012-10-05', '3005', '5002'),
('70009', '270.65', '2012-09-10', '3001', '5005'),
('70002', '65.26', '2012-10-05', '3002', '5003'),
('70004', '110.5', '2012-08-17', '3009', '5007'),
('70007', '948.5', '2012-09-10', '3005', '5005'),
('70005', '2400.6', '2012-07-27', '3007', '5006');

SELECT Customer.cust_name, Salesman.name, Salesman.city
FROM Customer
JOIN Salesman ON Customer.city = Salesman.city;

SELECT Customer.cust_name, Salesman.name
FROM Customer
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id;

SELECT Orders.ord_no, Customer.cust_name, Orders.customer_id, Orders.salesman_id
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
WHERE Customer.city <> Salesman.city;

SELECT Orders.ord_no, Customer.cust_name
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id;

SELECT Customer.cust_name AS "Customer", Customer.grade AS "GRADE"
FROM Customer
WHERE Customer.grade IS NOT NULL AND Customer.grade != '';

SELECT 
    Customer.cust_name AS "Customer",
    Customer.city AS "City",
    Salesman.name AS "Salesman",
    Salesman.Commission
FROM Customer
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id
WHERE CAST(Salesman.Commission AS REAL) BETWEEN 0.12 AND 0.14;

SELECT
    Orders.ord_no,
    Customer.cust_name,
    Salesman.Commission AS "Commission%",
    CAST(Orders.purch_amt AS REAL) * CAST(Salesman.Commission AS REAL) AS "Commission"
FROM Orders
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
JOIN Customer ON Orders.customer_id = Customer.customer_id
WHERE CAST(Customer.grade AS INTEGER) >= 200;

SELECT Customer.*, Orders.*
FROM Customer
JOIN Orders ON Customer.customer_id = Orders.customer_id;