-- Enhanced Test Data for E-Commerce Database
-- Includes multiple orders per day for better query testing
-- All data respects database constraints and foreign key relationships

-- 1. Insert Categories (no dependencies)
INSERT INTO Category (Category_ID, Category_Name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home & Garden'),
(5, 'Sports'),
(6, 'Toys'),
(7, 'Food & Beverage');

-- 2. Insert Products (no dependencies)
INSERT INTO Product (Product_ID, Name, Description, Price, Stock_QTY) VALUES
-- Electronics
(101, 'Laptop', 'High-performance laptop 16GB RAM', 899.99, 25),
(102, 'Smartphone', '5G enabled smartphone 128GB', 599.99, 50),
(103, 'Wireless Headphones', 'Noise-canceling Bluetooth headphones', 149.99, 100),
(104, 'Tablet', '10-inch tablet with stylus', 449.99, 40),
(105, 'Smartwatch', 'Fitness tracking smartwatch', 249.99, 60),
(106, 'Wireless Mouse', 'Ergonomic wireless mouse', 29.99, 150),
(107, 'USB-C Hub', '7-in-1 USB-C hub adapter', 39.99, 80),
-- Clothing
(201, 'T-Shirt', 'Cotton casual t-shirt', 19.99, 200),
(202, 'Jeans', 'Denim blue jeans slim fit', 49.99, 150),
(203, 'Hoodie', 'Warm fleece hoodie', 39.99, 120),
(204, 'Sneakers', 'Comfortable running sneakers', 79.99, 90),
(205, 'Winter Jacket', 'Waterproof winter jacket', 129.99, 60),
-- Books
(301, 'Fiction Novel', 'Best-selling fiction novel', 14.99, 75),
(302, 'Cookbook', 'Professional cooking guide', 29.99, 40),
(303, 'Programming Book', 'Learn Python programming', 44.99, 55),
(304, 'Business Book', 'Entrepreneurship essentials', 34.99, 45),
-- Home & Garden
(401, 'Garden Tools Set', 'Complete gardening toolkit', 79.99, 30),
(402, 'Coffee Maker', 'Automatic coffee machine', 89.99, 45),
(403, 'Blender', 'High-speed blender 1000W', 69.99, 50),
(404, 'Vacuum Cleaner', 'Cordless vacuum cleaner', 199.99, 35),
-- Sports
(501, 'Basketball', 'Professional basketball', 24.99, 80),
(502, 'Yoga Mat', 'Non-slip exercise mat', 34.99, 120),
(503, 'Dumbbells Set', '20kg adjustable dumbbells', 89.99, 40),
(504, 'Resistance Bands', 'Set of 5 resistance bands', 19.99, 100),
-- Toys
(601, 'Board Game', 'Strategy board game for families', 34.99, 70),
(602, 'Puzzle', '1000-piece jigsaw puzzle', 19.99, 85),
(603, 'Action Figure', 'Collectible action figure', 24.99, 95),
-- Food & Beverage
(701, 'Organic Tea Set', 'Premium organic tea collection', 29.99, 60),
(702, 'Coffee Beans', 'Arabica coffee beans 1kg', 24.99, 100),
(703, 'Chocolate Box', 'Assorted gourmet chocolates', 19.99, 120);

-- 3. Insert Product_Category relationships (requires Category and Product)
INSERT INTO Product_Category (Category_ID, Product_ID) VALUES
-- Electronics
(1, 101), (1, 102), (1, 103), (1, 104), (1, 105), (1, 106), (1, 107),
-- Clothing
(2, 201), (2, 202), (2, 203), (2, 204), (2, 205),
-- Books
(3, 301), (3, 302), (3, 303), (3, 304),
-- Home & Garden
(4, 401), (4, 402), (4, 403), (4, 404),
-- Sports
(5, 501), (5, 502), (5, 503), (5, 504),
-- Toys
(6, 601), (6, 602), (6, 603),
-- Food & Beverage
(7, 701), (7, 702), (7, 703);

-- 4. Insert Customers (no dependencies)
INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Email, Password) VALUES
(1001, 'John', 'Smith', 'john.smith@email.com', 'hashed_password_1'),
(1002, 'Sarah', 'Johnson', 'sarah.j@email.com', 'hashed_password_2'),
(1003, 'Michael', 'Williams', 'michael.w@email.com', 'hashed_password_3'),
(1004, 'Emily', 'Brown', 'emily.brown@email.com', 'hashed_password_4'),
(1005, 'David', 'Jones', 'david.jones@email.com', 'hashed_password_5'),
(1006, 'Lisa', 'Garcia', 'lisa.garcia@email.com', 'hashed_password_6'),
(1007, 'James', 'Martinez', 'james.m@email.com', 'hashed_password_7'),
(1008, 'Jennifer', 'Davis', 'jennifer.d@email.com', 'hashed_password_8'),
(1009, 'Robert', 'Miller', 'robert.miller@email.com', 'hashed_password_9'),
(1010, 'Maria', 'Rodriguez', 'maria.r@email.com', 'hashed_password_10'),
(1011, 'William', 'Wilson', 'william.w@email.com', 'hashed_password_11'),
(1012, 'Patricia', 'Anderson', 'patricia.a@email.com', 'hashed_password_12');

-- 5. Insert Orders (requires Customer) - Multiple orders per day
INSERT INTO Orders (Order_ID, Order_Date, Total_Amount, Customer_ID) VALUES
-- November 1, 2024 - 5 orders
(5001, '2024-11-01', 899.99, 1001),
(5002, '2024-11-01', 649.98, 1002),
(5003, '2024-11-01', 194.97, 1003),
(5004, '2024-11-01', 349.96, 1004),
(5005, '2024-11-01', 229.98, 1005),

-- November 2, 2024 - 4 orders
(5006, '2024-11-02', 1049.98, 1001),
(5007, '2024-11-02', 164.98, 1006),
(5008, '2024-11-02', 119.97, 1007),
(5009, '2024-11-02', 89.99, 1008),

-- November 3, 2024 - 6 orders
(5010, '2024-11-03', 574.97, 1002),
(5011, '2024-11-03', 924.98, 1009),
(5012, '2024-11-03', 129.97, 1010),
(5013, '2024-11-03', 349.97, 1011),
(5014, '2024-11-03', 299.95, 1003),
(5015, '2024-11-03', 199.96, 1012),

-- November 4, 2024 - 5 orders
(5016, '2024-11-04', 449.99, 1004),
(5017, '2024-11-04', 279.96, 1005),
(5018, '2024-11-04', 159.98, 1006),
(5019, '2024-11-04', 549.95, 1007),
(5020, '2024-11-04', 89.97, 1008),

-- November 5, 2024 - 4 orders
(5021, '2024-11-05', 699.97, 1009),
(5022, '2024-11-05', 169.95, 1010),
(5023, '2024-11-05', 249.99, 1001),
(5024, '2024-11-05', 379.96, 1011),

-- November 6, 2024 - 3 orders
(5025, '2024-11-06', 129.98, 1012),
(5026, '2024-11-06', 799.98, 1002),
(5027, '2024-11-06', 214.97, 1003);

-- 6. Insert Order_Details (requires Orders and Product)

-- Order 5001: Customer 1001 - Electronics
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5001, 101, 1, 899.99);

-- Order 5002: Customer 1002 - Electronics combo
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5002, 102, 1, 599.99),
(5002, 103, 1, 149.99);

-- Order 5003: Customer 1003 - Clothing
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5003, 201, 3, 19.99),
(5003, 202, 2, 49.99);

-- Order 5004: Customer 1004 - Mixed (Sports + Clothing)
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5004, 204, 1, 79.99),
(5004, 501, 2, 24.99),
(5004, 502, 5, 34.99);

-- Order 5005: Customer 1005 - Books + Food
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5005, 301, 3, 14.99),
(5005, 302, 2, 29.99),
(5005, 701, 4, 29.99);

-- Order 5006: Customer 1001 - High-value electronics
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5006, 101, 1, 899.99),
(5006, 105, 1, 249.99);

-- Order 5007: Customer 1006 - Home & Garden
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5007, 401, 1, 79.99),
(5007, 402, 1, 89.99);

-- Order 5008: Customer 1007 - Sports equipment
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5008, 501, 2, 24.99),
(5008, 502, 2, 34.99);

-- Order 5009: Customer 1008 - Home appliance
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5009, 402, 1, 89.99);

-- Order 5010: Customer 1002 - Bulk clothing
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5010, 201, 10, 19.99),
(5010, 202, 5, 49.99);

-- Order 5011: Customer 1009 - Premium electronics
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5011, 102, 1, 599.99),
(5011, 103, 2, 149.99),
(5011, 105, 1, 249.99);

-- Order 5012: Customer 1010 - Toys + Books
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5012, 601, 2, 34.99),
(5012, 303, 1, 44.99);

-- Order 5013: Customer 1011 - Mixed items
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5013, 103, 1, 149.99),
(5013, 201, 5, 19.99),
(5013, 502, 2, 34.99);

-- Order 5014: Customer 1003 - Clothing
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5014, 203, 3, 39.99),
(5014, 204, 2, 79.99);

-- Order 5015: Customer 1012 - Home + Food
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5015, 403, 1, 69.99),
(5015, 702, 3, 24.99),
(5015, 703, 2, 19.99);

-- Order 5016: Customer 1004 - Electronics
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5016, 104, 1, 449.99);

-- Order 5017: Customer 1005 - Sports + Clothing
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5017, 503, 1, 89.99),
(5017, 504, 5, 19.99),
(5017, 203, 2, 39.99);

-- Order 5018: Customer 1006 - Books
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5018, 303, 2, 44.99),
(5018, 304, 2, 34.99);

-- Order 5019: Customer 1007 - Premium items
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5019, 104, 1, 449.99),
(5019, 205, 1, 129.99);

-- Order 5020: Customer 1008 - Food + Books
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5020, 301, 3, 14.99),
(5020, 701, 1, 29.99);

-- Order 5021: Customer 1009 - Electronics bundle
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5021, 102, 1, 599.99),
(5021, 106, 2, 29.99),
(5021, 107, 1, 39.99);

-- Order 5022: Customer 1010 - Toys
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5022, 601, 2, 34.99),
(5022, 602, 3, 19.99),
(5022, 603, 2, 24.99);

-- Order 5023: Customer 1001 - Smartwatch
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5023, 105, 1, 249.99);

-- Order 5024: Customer 1011 - Home appliances
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5024, 402, 2, 89.99),
(5024, 404, 1, 199.99);

-- Order 5025: Customer 1012 - Clothing
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5025, 201, 3, 19.99),
(5025, 203, 2, 39.99);

-- Order 5026: Customer 1002 - High-value order
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5026, 101, 1, 899.99),
(5026, 205, 1, 129.99);

-- Order 5027: Customer 1003 - Mixed
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5027, 303, 2, 44.99),
(5027, 502, 3, 34.99);

-- 7. Insert Order_History (historical records matching orders)
INSERT INTO Order_History (Order_ID, Customer_ID, Customer_Full_Name, Total_Amount, Order_Date) VALUES
(5001, 1001, 'John Smith', 899.99, '2024-11-01'),
(5002, 1002, 'Sarah Johnson', 749.98, '2024-11-01'),
(5003, 1003, 'Michael Williams', 159.95, '2024-11-01'),
(5004, 1004, 'Emily Brown', 279.96, '2024-11-01'),
(5005, 1005, 'David Jones', 209.97, '2024-11-01'),
(5006, 1001, 'John Smith', 1149.98, '2024-11-02'),
(5007, 1006, 'Lisa Garcia', 169.98, '2024-11-02'),
(5008, 1007, 'James Martinez', 119.96, '2024-11-02'),
(5009, 1008, 'Jennifer Davis', 89.99, '2024-11-02'),
(5010, 1002, 'Sarah Johnson', 449.85, '2024-11-03'),
(5011, 1009, 'Robert Miller', 1099.96, '2024-11-03'),
(5012, 1010, 'Maria Rodriguez', 114.97, '2024-11-03'),
(5013, 1011, 'William Wilson', 329.93, '2024-11-03'),
(5014, 1003, 'Michael Williams', 279.95, '2024-11-03'),
(5015, 1012, 'Patricia Anderson', 184.96, '2024-11-03'),
(5016, 1004, 'Emily Brown', 449.99, '2024-11-04'),
(5017, 1005, 'David Jones', 269.96, '2024-11-04'),
(5018, 1006, 'Lisa Garcia', 159.96, '2024-11-04'),
(5019, 1007, 'James Martinez', 579.98, '2024-11-04'),
(5020, 1008, 'Jennifer Davis', 74.97, '2024-11-04'),
(5021, 1009, 'Robert Miller', 699.96, '2024-11-05'),
(5022, 1010, 'Maria Rodriguez', 159.94, '2024-11-05'),
(5023, 1001, 'John Smith', 249.99, '2024-11-05'),
(5024, 1011, 'William Wilson', 379.97, '2024-11-05'),
(5025, 1012, 'Patricia Anderson', 139.95, '2024-11-06'),
(5026, 1002, 'Sarah Johnson', 1029.98, '2024-11-06'),
(5027, 1003, 'Michael Williams', 194.95, '2024-11-06');

