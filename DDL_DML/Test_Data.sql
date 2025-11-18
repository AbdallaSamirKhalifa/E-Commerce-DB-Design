-- Insert test data for E-Commerce database
-- All data respects constraints and foreign key relationships

-- 1. Insert Categories (no dependencies)
INSERT INTO Category (Category_ID, Category_Name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home & Garden'),
(5, 'Sports');

-- 2. Insert Products (no dependencies)
INSERT INTO Product (Product_ID, Name, Description, Price, Stock_QTY) VALUES
(101, 'Laptop', 'High-performance laptop', 899.99, 25),
(102, 'Smartphone', '5G enabled smartphone', 599.99, 50),
(103, 'Wireless Headphones', 'Noise-canceling headphones', 149.99, 100),
(104, 'T-Shirt', 'Cotton casual t-shirt', 19.99, 200),
(105, 'Jeans', 'Denim blue jeans', 49.99, 150),
(106, 'Novel Book', 'Best-selling fiction novel', 14.99, 75),
(107, 'Cookbook', 'Professional cooking guide', 29.99, 40),
(108, 'Garden Tools Set', 'Complete gardening toolkit', 79.99, 30),
(109, 'Coffee Maker', 'Automatic coffee machine', 89.99, 45),
(110, 'Basketball', 'Professional basketball', 24.99, 80),
(111, 'Yoga Mat', 'Non-slip exercise mat', 34.99, 120),
(112, 'Smartwatch', 'Fitness tracking smartwatch', 249.99, 60);

-- 3. Insert Product_Category relationships (requires Category and Product)
INSERT INTO Product_Category (Category_ID, Product_ID) VALUES
(1, 101), -- Electronics: Laptop
(1, 102), -- Electronics: Smartphone
(1, 103), -- Electronics: Wireless Headphones
(1, 112), -- Electronics: Smartwatch
(2, 104), -- Clothing: T-Shirt
(2, 105), -- Clothing: Jeans
(3, 106), -- Books: Novel Book
(3, 107), -- Books: Cookbook
(4, 108), -- Home & Garden: Garden Tools Set
(4, 109), -- Home & Garden: Coffee Maker
(5, 110), -- Sports: Basketball
(5, 111); -- Sports: Yoga Mat

-- 4. Insert Customers (no dependencies)
INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Email, Password) VALUES
(1001, 'John', 'Smith', 'john.smith@email.com', 'hashed_password_1'),
(1002, 'Sarah', 'Johnson', 'sarah.j@email.com', 'hashed_password_2'),
(1003, 'Michael', 'Williams', 'michael.w@email.com', 'hashed_password_3'),
(1004, 'Emily', 'Brown', 'emily.brown@email.com', 'hashed_password_4'),
(1005, 'David', 'Jones', 'david.jones@email.com', 'hashed_password_5'),
(1006, 'Lisa', 'Garcia', 'lisa.garcia@email.com', 'hashed_password_6'),
(1007, 'James', 'Martinez', 'james.m@email.com', 'hashed_password_7'),
(1008, 'Jennifer', 'Davis', 'jennifer.d@email.com', 'hashed_password_8');

-- 5. Insert Orders (requires Customer)
INSERT INTO Orders (Order_ID, Order_Date, Total_Amount, Customer_ID) VALUES
(5001, '2024-11-01 10:30:00', 899.99, 1001),
(5002, '2024-11-02 14:15:00', 649.98, 1002),
(5003, '2024-11-03 09:20:00', 194.97, 1003),
(5004, '2024-11-04 16:45:00', 1049.98, 1001),
(5005, '2024-11-05 11:00:00', 69.98, 1004),
(5006, '2024-11-06 13:30:00', 164.98, 1005),
(5007, '2024-11-07 15:20:00', 924.98, 1006),
(5008, '2024-11-08 10:10:00', 129.97, 1007),
(5009, '2024-11-09 12:40:00', 349.97, 1008),
(5010, '2024-11-10 14:50:00', 574.97, 1002);

-- 6. Insert Order_Details (requires Orders and Product)
-- Order 5001: Customer 1001 - Laptop
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5001, 101, 1, 899.99);

-- Order 5002: Customer 1002 - Smartphone + Headphones
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5002, 102, 1, 599.99),
(5002, 103, 1, 149.99);

-- Order 5003: Customer 1003 - T-Shirts + Jeans
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5003, 104, 3, 19.99),
(5003, 105, 2, 49.99);

-- Order 5004: Customer 1001 - Laptop + Smartwatch
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5004, 101, 1, 899.99),
(5004, 112, 1, 249.99);

-- Order 5005: Customer 1004 - Books
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5005, 106, 2, 14.99),
(5005, 107, 1, 29.99);

-- Order 5006: Customer 1005 - Garden Tools + Coffee Maker
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5006, 108, 1, 79.99),
(5006, 109, 1, 89.99);

-- Order 5007: Customer 1006 - Multiple Electronics
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5007, 102, 1, 599.99),
(5007, 103, 2, 149.99),
(5007, 112, 1, 249.99);

-- Order 5008: Customer 1007 - Sports Equipment
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5008, 110, 2, 24.99),
(5008, 111, 2, 34.99);

-- Order 5009: Customer 1008 - Mixed Items
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5009, 103, 1, 149.99),
(5009, 104, 5, 19.99),
(5009, 111, 2, 34.99);

-- Order 5010: Customer 1002 - Clothing
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5010, 104, 10, 19.99),
(5010, 105, 5, 49.99);

-- 7. Insert Order_History (historical records)
INSERT INTO Order_History (Order_ID, Customer_ID, Customer_Full_Name, Total_Amount, Order_Date) VALUES
(5001, 1001, 'John Smith', 899.99, '2024-11-01 10:30:00'),
(5002, 1002, 'Sarah Johnson', 749.98, '2024-11-02 14:15:00'),
(5003, 1003, 'Michael Williams', 159.95, '2024-11-03 09:20:00'),
(5004, 1001, 'John Smith', 1149.98, '2024-11-04 16:45:00'),
(5005, 1004, 'Emily Brown', 59.97, '2024-11-05 11:00:00'),
(5006, 1005, 'David Jones', 169.98, '2024-11-06 13:30:00'),
(5007, 1006, 'Lisa Garcia', 1099.96, '2024-11-07 15:20:00'),
(5008, 1007, 'James Martinez', 119.96, '2024-11-08 10:10:00'),
(5009, 1008, 'Jennifer Davis', 329.93, '2024-11-09 12:40:00'),
(5010, 1002, 'Sarah Johnson', 449.85, '2024-11-10 14:50:00');

-- Verification Queries (optional - uncomment to test)
-- SELECT * FROM Category;
-- SELECT * FROM Product;
-- SELECT * FROM Product_Category;
-- SELECT * FROM Customer;
-- SELECT * FROM Orders;
-- SELECT * FROM Order_Details;
-- SELECT * FROM Order_History;