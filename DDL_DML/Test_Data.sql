-- Enhanced Test Data for E-Commerce Database
-- Updated schema: Product has Category_ID (no Product_Category table)
-- Covers October and November 2024 (2 months)
-- Uses TIMESTAMP for dates
-- Dynamic Order_History with JSONB Products field
-- All data respects database constraints

-- 1. Insert Categories (no dependencies)
INSERT INTO Category (Category_ID, Category_Name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home & Garden'),
(5, 'Sports'),
(6, 'Toys'),
(7, 'Food & Beverage'),
(8, 'Health & Beauty'),
(9, 'Automotive');

-- 2. Insert Products (requires Category)
INSERT INTO Product (Product_ID, Name, Description, Price, Stock_QTY, Category_ID) VALUES
-- Electronics (Category 1)
(101, 'Laptop Pro', 'High-performance laptop 16GB RAM', 1299.99, 35, 1),
(102, 'Smartphone X', '5G enabled smartphone 256GB', 899.99, 75, 1),
(103, 'Wireless Headphones', 'Noise-canceling Bluetooth headphones', 149.99, 120, 1),
(104, 'Tablet Ultra', '10-inch tablet with stylus', 549.99, 50, 1),
(105, 'Smartwatch Pro', 'Fitness tracking smartwatch', 279.99, 85, 1),
(106, 'Wireless Mouse', 'Ergonomic wireless mouse', 34.99, 200, 1),
(107, 'USB-C Hub', '7-in-1 USB-C hub adapter', 44.99, 150, 1),
(108, '4K Monitor', '27-inch 4K UHD monitor', 399.99, 40, 1),
(109, 'Mechanical Keyboard', 'RGB gaming keyboard', 129.99, 65, 1),
(110, 'Webcam HD', '1080p HD webcam', 79.99, 90, 1),

-- Clothing (Category 2)
(201, 'T-Shirt Basic', 'Cotton casual t-shirt', 19.99, 300, 2),
(202, 'Jeans Classic', 'Denim blue jeans slim fit', 59.99, 200, 2),
(203, 'Hoodie Warm', 'Warm fleece hoodie', 44.99, 150, 2),
(204, 'Sneakers Sport', 'Comfortable running sneakers', 89.99, 120, 2),
(205, 'Winter Jacket', 'Waterproof winter jacket', 149.99, 80, 2),
(206, 'Dress Shirt', 'Formal dress shirt', 39.99, 110, 2),
(207, 'Cargo Pants', 'Utility cargo pants', 54.99, 95, 2),
(208, 'Baseball Cap', 'Adjustable baseball cap', 24.99, 180, 2),

-- Books (Category 3)
(301, 'Fiction Novel', 'Best-selling mystery thriller', 16.99, 100, 3),
(302, 'Cookbook Master', 'Professional cooking guide', 34.99, 60, 3),
(303, 'Programming Guide', 'Learn Python programming', 49.99, 70, 3),
(304, 'Business Strategy', 'Entrepreneurship essentials', 39.99, 55, 3),
(305, 'Self-Help Book', 'Personal development guide', 24.99, 85, 3),
(306, 'Children Book', 'Illustrated storybook', 12.99, 140, 3),

-- Home & Garden (Category 4)
(401, 'Garden Tools Set', 'Complete gardening toolkit', 89.99, 45, 4),
(402, 'Coffee Maker Pro', 'Automatic coffee machine', 119.99, 60, 4),
(403, 'Blender Max', 'High-speed blender 1200W', 79.99, 70, 4),
(404, 'Vacuum Robot', 'Smart robot vacuum cleaner', 299.99, 50, 4),
(405, 'Air Purifier', 'HEPA air purifier', 159.99, 55, 4),
(406, 'Electric Kettle', 'Fast boiling electric kettle', 44.99, 100, 4),

-- Sports (Category 5)
(501, 'Basketball Pro', 'Professional basketball', 29.99, 110, 5),
(502, 'Yoga Mat Premium', 'Non-slip exercise mat', 39.99, 140, 5),
(503, 'Dumbbells Set', '20kg adjustable dumbbells', 99.99, 60, 5),
(504, 'Resistance Bands', 'Set of 5 resistance bands', 24.99, 130, 5),
(505, 'Jump Rope', 'Speed jump rope', 14.99, 160, 5),
(506, 'Tennis Racket', 'Carbon fiber tennis racket', 119.99, 45, 5),

-- Toys (Category 6)
(601, 'Board Game Family', 'Strategy board game for families', 39.99, 90, 6),
(602, 'Puzzle 1000', '1000-piece jigsaw puzzle', 22.99, 105, 6),
(603, 'Action Figure Hero', 'Collectible action figure', 29.99, 120, 6),
(604, 'Building Blocks', '500-piece building set', 49.99, 75, 6),
(605, 'Remote Car', 'RC racing car', 69.99, 65, 6),

-- Food & Beverage (Category 7)
(701, 'Organic Tea Set', 'Premium organic tea collection', 34.99, 80, 7),
(702, 'Coffee Beans', 'Arabica coffee beans 1kg', 27.99, 130, 7),
(703, 'Chocolate Box', 'Assorted gourmet chocolates', 24.99, 150, 7),
(704, 'Protein Powder', 'Whey protein 2kg', 54.99, 90, 7),
(705, 'Energy Bars', 'Pack of 12 energy bars', 19.99, 170, 7),

-- Health & Beauty (Category 8)
(801, 'Electric Toothbrush', 'Rechargeable toothbrush', 89.99, 70, 8),
(802, 'Hair Dryer Pro', 'Professional hair dryer', 64.99, 85, 8),
(803, 'Facial Cleanser', 'Gentle facial cleanser 200ml', 29.99, 140, 8),
(804, 'Moisturizer', 'Hydrating face moisturizer', 39.99, 120, 8),
(805, 'Vitamin C Serum', 'Anti-aging vitamin C serum', 44.99, 95, 8),

-- Automotive (Category 9)
(901, 'Car Phone Mount', 'Universal phone holder', 19.99, 180, 9),
(902, 'Dash Cam', '1080p dashboard camera', 89.99, 65, 9),
(903, 'Car Vacuum', 'Portable car vacuum cleaner', 49.99, 75, 9),
(904, 'Tire Inflator', 'Digital tire pressure pump', 39.99, 90, 9);

-- 3. Insert Customers (no dependencies)
INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Email, Password) VALUES
(1001, 'John', 'Smith', 'john.smith@email.com', '$2y$10$hash1'),
(1002, 'Sarah', 'Johnson', 'sarah.j@email.com', '$2y$10$hash2'),
(1003, 'Michael', 'Williams', 'michael.w@email.com', '$2y$10$hash3'),
(1004, 'Emily', 'Brown', 'emily.brown@email.com', '$2y$10$hash4'),
(1005, 'David', 'Jones', 'david.jones@email.com', '$2y$10$hash5'),
(1006, 'Lisa', 'Garcia', 'lisa.garcia@email.com', '$2y$10$hash6'),
(1007, 'James', 'Martinez', 'james.m@email.com', '$2y$10$hash7'),
(1008, 'Jennifer', 'Davis', 'jennifer.d@email.com', '$2y$10$hash8'),
(1009, 'Robert', 'Miller', 'robert.miller@email.com', '$2y$10$hash9'),
(1010, 'Maria', 'Rodriguez', 'maria.r@email.com', '$2y$10$hash10'),
(1011, 'William', 'Wilson', 'william.w@email.com', '$2y$10$hash11'),
(1012, 'Patricia', 'Anderson', 'patricia.a@email.com', '$2y$10$hash12'),
(1013, 'Christopher', 'Taylor', 'chris.taylor@email.com', '$2y$10$hash13'),
(1014, 'Linda', 'Thomas', 'linda.thomas@email.com', '$2y$10$hash14'),
(1015, 'Daniel', 'Moore', 'daniel.moore@email.com', '$2y$10$hash15');

-- 4. Insert Orders - October and November 2024 with TIMESTAMP
INSERT INTO Orders (Order_ID, Order_Date, Total_Amount, Customer_ID) VALUES
-- October 2024 Orders (35 orders)
(5001, '2024-10-01 09:15:23', 1299.99, 1001),
(5002, '2024-10-01 14:32:11', 1049.98, 1002),
(5003, '2024-10-02 10:45:30', 159.95, 1003),
(5004, '2024-10-02 16:20:45', 279.96, 1004),
(5005, '2024-10-03 11:05:12', 209.97, 1005),
(5006, '2024-10-03 15:40:33', 1579.98, 1001),
(5007, '2024-10-04 08:25:44', 209.98, 1006),
(5008, '2024-10-04 13:50:21', 119.96, 1007),
(5009, '2024-10-05 10:30:15', 299.99, 1008),
(5010, '2024-10-05 17:15:42', 499.85, 1002),
(5011, '2024-10-06 09:20:30', 1379.96, 1009),
(5012, '2024-10-07 12:35:18', 129.97, 1010),
(5013, '2024-10-07 16:45:50', 329.93, 1011),
(5014, '2024-10-08 10:10:25', 299.95, 1003),
(5015, '2024-10-08 14:55:33', 184.96, 1012),
(5016, '2024-10-09 11:20:40', 549.99, 1004),
(5017, '2024-10-10 09:45:15', 289.96, 1005),
(5018, '2024-10-10 15:30:22', 179.96, 1006),
(5019, '2024-10-11 13:15:50', 699.98, 1007),
(5020, '2024-10-12 10:40:33', 85.96, 1008),
(5021, '2024-10-13 11:25:18', 1014.96, 1009),
(5022, '2024-10-14 14:50:42', 182.93, 1010),
(5023, '2024-10-15 09:35:27', 279.99, 1001),
(5024, '2024-10-15 16:20:55', 539.97, 1011),
(5025, '2024-10-16 10:15:30', 149.95, 1012),
(5026, '2024-10-17 12:40:18', 1029.98, 1002),
(5027, '2024-10-18 15:25:44', 219.95, 1003),
(5028, '2024-10-19 09:50:22', 399.99, 1013),
(5029, '2024-10-20 13:30:15', 1064.97, 1014),
(5030, '2024-10-21 11:45:38', 324.97, 1015),
(5031, '2024-10-22 14:20:50', 629.98, 1001),
(5032, '2024-10-23 10:35:12', 179.98, 1002),
(5033, '2024-10-24 16:15:33', 1308.97, 1004),
(5034, '2024-10-25 09:25:45', 274.92, 1005),
(5035, '2024-10-26 12:50:28', 169.96, 1006),

-- November 2024 Orders (45 orders)
(5036, '2024-11-01 08:30:15', 899.99, 1007),
(5037, '2024-11-01 11:45:22', 449.97, 1008),
(5038, '2024-11-01 14:20:40', 624.90, 1009),
(5039, '2024-11-02 09:15:33', 304.93, 1010),
(5040, '2024-11-02 13:40:18', 549.99, 1011),
(5041, '2024-11-02 16:25:50', 1674.90, 1012),
(5042, '2024-11-03 10:10:25', 219.96, 1013),
(5043, '2024-11-03 14:35:42', 479.96, 1014),
(5044, '2024-11-04 09:20:30', 354.94, 1015),
(5045, '2024-11-04 12:50:15', 1299.99, 1001),
(5046, '2024-11-05 11:15:38', 249.94, 1002),
(5047, '2024-11-05 15:40:22', 599.94, 1003),
(5048, '2024-11-06 10:25:50', 1328.97, 1004),
(5049, '2024-11-06 14:10:33', 162.95, 1005),
(5050, '2024-11-07 09:35:18', 799.98, 1006),
(5051, '2024-11-07 13:20:45', 344.92, 1007),
(5052, '2024-11-08 11:50:28', 509.93, 1008),
(5053, '2024-11-08 15:15:12', 273.89, 1009),
(5054, '2024-11-09 10:40:35', 629.98, 1010),
(5055, '2024-11-09 14:25:50', 179.96, 1011),
(5056, '2024-11-10 09:15:22', 899.99, 1012),
(5057, '2024-11-10 12:45:40', 424.95, 1013),
(5058, '2024-11-11 11:20:15', 748.90, 1014),
(5059, '2024-11-11 15:50:33', 404.96, 1015),
(5060, '2024-11-12 10:30:45', 1749.96, 1001),
(5061, '2024-11-12 14:15:28', 195.94, 1002),
(5062, '2024-11-13 09:40:18', 1978.97, 1003),
(5063, '2024-11-13 13:25:50', 359.91, 1004),
(5064, '2024-11-14 11:10:35', 579.90, 1005),
(5065, '2024-11-14 15:45:22', 259.94, 1006),
(5066, '2024-11-15 10:20:40', 899.99, 1007),
(5067, '2024-11-15 14:35:15', 414.96, 1008),
(5068, '2024-11-16 09:50:28', 574.90, 1009),
(5069, '2024-11-16 13:15:42', 239.87, 1010),
(5070, '2024-11-17 11:40:18', 663.96, 1011),
(5071, '2024-11-17 15:25:33', 349.85, 1012),
(5072, '2024-11-18 10:10:50', 1769.96, 1013),
(5073, '2024-11-18 14:45:25', 379.92, 1014),
(5074, '2024-11-19 09:30:12', 499.93, 1015),
(5075, '2024-11-19 13:20:45', 288.89, 1001),
(5076, '2024-11-20 11:50:33', 1074.94, 1002),
(5077, '2024-11-20 15:15:18', 394.85, 1003),
(5078, '2024-11-21 10:35:40', 698.88, 1004),
(5079, '2024-11-21 14:20:22', 214.80, 1005),
(5080, '2024-11-22 09:45:15', 1828.97, 1006);

-- 5. Insert Order_Details
-- October Orders Details
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5001, 101, 1, 1299.99),
(5002, 102, 1, 899.99), (5002, 103, 1, 149.99),
(5003, 201, 3, 19.99), (5003, 202, 2, 59.99),
(5004, 204, 1, 89.99), (5004, 501, 2, 29.99), (5004, 502, 4, 39.99),
(5005, 301, 3, 16.99), (5005, 302, 2, 34.99), (5005, 701, 2, 34.99),
(5006, 101, 1, 1299.99), (5006, 105, 1, 279.99),
(5007, 401, 1, 89.99), (5007, 402, 1, 119.99),
(5008, 501, 2, 29.99), (5008, 502, 2, 39.99),
(5009, 404, 1, 299.99),
(5010, 201, 10, 19.99), (5010, 202, 5, 59.99),
(5011, 102, 1, 899.99), (5011, 103, 2, 149.99), (5011, 105, 1, 279.99),
(5012, 601, 2, 39.99), (5012, 303, 1, 49.99),
(5013, 103, 1, 149.99), (5013, 201, 5, 19.99), (5013, 502, 2, 39.99),
(5014, 203, 3, 44.99), (5014, 204, 2, 89.99),
(5015, 403, 1, 79.99), (5015, 702, 2, 27.99), (5015, 703, 2, 24.99),
(5016, 104, 1, 549.99),
(5017, 503, 1, 99.99), (5017, 504, 5, 24.99), (5017, 203, 2, 44.99),
(5018, 303, 2, 49.99), (5018, 304, 2, 39.99),
(5019, 104, 1, 549.99), (5019, 205, 1, 149.99),
(5020, 301, 3, 16.99), (5020, 701, 1, 34.99),
(5021, 102, 1, 899.99), (5021, 106, 2, 34.99), (5021, 107, 2, 44.99),
(5022, 601, 2, 39.99), (5022, 602, 3, 22.99), (5022, 603, 2, 29.99),
(5023, 105, 1, 279.99),
(5024, 402, 2, 119.99), (5024, 404, 1, 299.99),
(5025, 201, 3, 19.99), (5025, 203, 2, 44.99),
(5026, 101, 1, 1299.99), (5026, 205, 2, 149.99),
(5027, 303, 2, 49.99), (5027, 502, 3, 39.99),
(5028, 108, 1, 399.99),
(5029, 102, 1, 899.99), (5029, 106, 1, 34.99), (5029, 109, 1, 129.99),
(5030, 403, 1, 79.99), (5030, 405, 1, 159.99), (5030, 406, 2, 44.99),
(5031, 104, 1, 549.99), (5031, 110, 1, 79.99),
(5032, 801, 2, 89.99),
(5033, 102, 1, 899.99), (5033, 105, 1, 279.99), (5033, 109, 1, 129.99),
(5034, 503, 1, 99.99), (5034, 504, 3, 24.99), (5034, 505, 5, 14.99),
(5035, 804, 2, 39.99), (5035, 805, 2, 44.99);

-- November Orders Details
INSERT INTO Order_Details (Order_ID, Product_ID, QTY, Unit_Price) VALUES
(5036, 102, 1, 899.99),
(5037, 103, 3, 149.99),
(5038, 201, 5, 19.99), (5038, 202, 5, 59.99), (5038, 203, 5, 44.99),
(5039, 302, 3, 34.99), (5039, 303, 4, 49.99),
(5040, 104, 1, 549.99),
(5041, 101, 1, 1299.99), (5041, 106, 5, 34.99), (5041, 107, 5, 44.99),
(5042, 901, 2, 19.99), (5042, 902, 2, 89.99),
(5043, 403, 2, 79.99), (5043, 405, 2, 159.99),
(5044, 204, 2, 89.99), (5044, 206, 3, 39.99), (5044, 207, 1, 54.99),
(5045, 101, 1, 1299.99),
(5046, 501, 3, 29.99), (5046, 502, 4, 39.99),
(5047, 402, 2, 119.99), (5047, 403, 4, 79.99),
(5048, 102, 1, 899.99), (5048, 103, 1, 149.99), (5048, 105, 1, 279.99),
(5049, 601, 2, 39.99), (5049, 602, 2, 22.99), (5049, 603, 2, 29.99),
(5050, 108, 2, 399.99),
(5051, 503, 1, 99.99), (5051, 504, 5, 24.99), (5051, 506, 1, 119.99),
(5052, 801, 2, 89.99), (5052, 802, 2, 64.99), (5052, 803, 5, 29.99),
(5053, 301, 5, 16.99), (5053, 305, 6, 24.99), (5053, 306, 3, 12.99),
(5054, 104, 1, 549.99), (5054, 110, 1, 79.99),
(5055, 903, 2, 49.99), (5055, 904, 2, 39.99),
(5056, 102, 1, 899.99),
(5057, 403, 2, 79.99), (5057, 704, 3, 54.99), (5057, 705, 5, 19.99),
(5058, 202, 5, 59.99), (5058, 203, 5, 44.99), (5058, 205, 1, 149.99),
(5059, 401, 2, 89.99), (5059, 406, 5, 44.99),
(5060, 101, 1, 1299.99), (5060, 103, 3, 149.99),
(5061, 701, 4, 34.99), (5061, 702, 2, 27.99),
(5062, 101, 1, 1299.99), (5062, 105, 1, 279.99), (5062, 108, 1, 399.99),
(5063, 604, 3, 49.99), (5063, 605, 3, 69.99),
(5064, 204, 2, 89.99), (5064, 502, 5, 39.99), (5064, 503, 1, 99.99),
(5065, 801, 1, 89.99), (5065, 803, 3, 29.99), (5065, 804, 2, 39.99),
(5066, 102, 1, 899.99),
(5067, 402, 1, 119.99), (5067, 405, 1, 159.99), (5067, 406, 3, 44.99),
(5068, 303, 5, 49.99), (5068, 304, 5, 39.99), (5068, 305, 5, 24.99),
(5069, 501, 3, 29.99), (5069, 505, 10, 14.99),
(5070, 104, 1, 549.99), (5070, 106, 2, 34.99), (5070, 107, 1, 44.99),
(5071, 201, 5, 19.99), (5071, 208, 10, 24.99),
(5072, 101, 1, 1299.99), (5072, 109, 1, 129.99), (5072, 110, 4, 79.99),
(5073, 902, 2, 89.99), (5073, 903, 4, 49.99),
(5074, 403, 3, 79.99), (5074, 802, 4, 64.99),
(5075, 602, 5, 22.99), (5075, 603, 6, 29.99),
(5076, 102, 1, 899.99), (5076, 106, 5, 34.99),
(5077, 701, 5, 34.99), (5077, 703, 5, 24.99), (5077, 705, 5, 19.99),
(5078, 202, 5, 59.99), (5078, 203, 5, 44.99), (5078, 206, 3, 39.99),
(5079, 301, 5, 16.99), (5079, 306, 10, 12.99),
(5080, 101, 1, 1299.99), (5080, 108, 1, 399.99), (5080, 109, 1, 129.99);

-- 6. Insert Order_History - DYNAMIC with JSONB Products
INSERT INTO Order_History (Order_ID, Customer_ID, Customer_Full_Name, Total_Amount, Order_Date, Products)
SELECT 
    o.Order_ID,
    o.Customer_ID,
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Full_Name,
    o.Total_Amount,
    o.Order_Date,
    (
        SELECT jsonb_agg(
            jsonb_build_object(
                'product_id', od.Product_ID,
                'product_name', p.Name,
                'quantity', od.QTY,
                'unit_price', od.Unit_Price,
                'subtotal', od.QTY * od.Unit_Price
            )
        )
        FROM Order_Details od
        INNER JOIN Product p ON od.Product_ID = p.Product_ID
        WHERE od.Order_ID = o.Order_ID
    ) AS Products
FROM Orders o
INNER JOIN Customer c ON o.Customer_ID = c.Customer_ID;