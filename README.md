# **E-Commerce Database Design**

This repository includes the **database design** and **SQL implementation** for an **E-Commerce Web Application**, created as a practice exercise inspired by concepts from the book **Practical Web Database Design**.

> ⚠️ **Note:** This project is currently under development. The database schema and other components are subject to change.

---

## **Motivation**

This project is part of a mentorship program aims to strengthening our **technical** and **interpersonal** skills to prepare for real-world market requirements.

---

## Project Structure

```
E-Commerce-Database/
├── README.md                     # Project documentation
|── ERD.png                       # Entity Relationship Diagram
|── Relational-Schema.png         # Database Schema
└── DDL_DML/
    |── Shcema.sql                # Database schema (CREATE statements)
    └── Test_Data.sql             # Sample data (INSERT statements)

```

---

## **Table of Contents**

- [Motivation](#motivation)
- [What's Included](#whats-included)
- [How to Browse](#how-to-browse)
- [ERD](#erd)
- [Relational Schema](#schema)
- [Schema DDL](#DDL)
- [Data For Testing](#test-data)
- [Queries](#queries)

---

## **What's Included**

- **Entity-Relationship Diagram (ERD)**.
- **Relational Schema**.
- **Normalization**
- **Denormalization**
- **Schema DDL**
- **Some queries to extract usefull data**
- Notes and explanations on relationships and design choices.

---

## **How to Browse**

All diagrams and SQL code are included directly in this `README.md` file for easy navigation and reading.

---

<h2 align="center" id="erd">ERD</h2>

[![ERD](./ERD.png)](./ERD.png)

The ERD includes core components of an E-Commerce system, such as:

- **Customer**
- **Products**
- **Categories**
- **Orders**
- **Order Details**

---

<h2 align="center" id="schema">Relational Schema</h2>

[![Relational Schema](./Relational-Schema.png)](./Relational-Schema.png)

This schema represents the core structure of a simplified E-Commerce system.  
While the design follows standard relational modeling practices, a small amount of **intentional denormalization** was applied to improve query performance and simplify reporting.

### Explanation:

- The **Order_History** table stores customer names ,total amounts, product informations and subtotal, even though this data also exists in other tables.  
  This avoids expensive joins when generating historical order summaries, this might slower the creating new order process but it could be fixed with a **background task** or **batch task** that runs once or twice a week to avoid this problem.
- Product pricing at the moment of purchase is copied into **Order_Details (Unit_Price)** to preserve price history, even if the product price changes later.

These denormalizations are chosen on purpose for practical advantages in analytics, reporting, and historical accuracy, while keeping the overall schema clear and maintainable.

---

<h2 align="center" id="DDL">Schema DDL</h2>

```sql

-- CREATE DATABASE E_Commerce

CREATE TABLE IF NOT EXISTS Category(
Category_ID INT PRIMARY KEY,
Category_Name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product(
Product_ID INT PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
Description VARCHAR(50) NOT NULL,
Price DECIMAL(7,2) NOT NULL CHECK(Price > 0),
Stock_QTY INT NOT NULL Check(Stock_QTY > 0),
Category_ID INT NOT NULL,
FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);


CREATE TABLE IF NOT EXISTS Customer(
Customer_ID INT PRIMARY KEY,
First_Name VARCHAR(20) NOT NULL,
Last_Name VARCHAR(20) NOT NULL,
Email VARCHAR(30) UNIQUE NOT NULL,
Password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders(
Order_ID INT PRIMARY KEY,
Order_Date TIMESTAMP DEFAULT CURRENT_DATE,
Total_Amount DECIMAL(9,2) NOT NULL CHECK(Total_Amount > 0),
Customer_ID INT NOT NULL,
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE IF NOT EXISTS Order_Details(
Order_ID INT ,
Product_ID INT ,
QTY INT NOT NULL CHECK(QTY > 0),
Unit_Price DECIMAL(7,2) NOT NULL CHECK(Unit_Price > 0),
PRIMARY KEY (Order_ID, Product_ID),
FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE IF NOT EXISTS Order_History(
order_history_id  SERIAL  PRIMARY KEY,
Order_ID INT NOT NULL,
product_id INT NOT NULL,
Customer_ID INT NOT NULL,
category_id int NOT NULL ,
Customer_Full_Name VARCHAR(40) NOT NULL,
Total_Amount DECIMAL(9,2) NOT NULL CHECK(Total_Amount > 0),
Order_Date TIMESTAMP NOT NULL,
product_name VARCHAR(30) NOT NULL,
subtotal DECIMAL(8,2) NOT NULL CHECK(subtotal > 0),
quantity INT NOT NULL CHECK(quantity > 0),
FOREIGN KEY (Order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (category_id) REFERENCES category(category_id)
)
```

---

<h2 align="center" id="test-data">Test Data</h2>

The database includes comprehensive sample data for testing and development:

All test data respects database constraints:

- ✅ Foreign key relationships
- ✅ CHECK constraints
- ✅ NOT NULL constraints

📄 **View full test data**: [Test_Data.sql](./DDL_DML/Test_Data.sql)

---

## <h2 align="center" id="queries">Queries</h2>

## query to generate a daily report of the total revenue for a specific date.

```sql
SELECT DATE(order_date) AS month,SUM(total_amount) revenue FROM orders
GROUP BY month
HAVING DATE(order_date) = <date>;
```

### Smaple Output

| month      | Revenue |
| ---------- | ------- |
| 2024-11-03 | 699.92  |

---

## SQL query to generate a monthly report of the top-selling products in a given month.

```sql
 SELECT  DATE_PART('MONTH', order_date) AS month, product_id, product_name,
 SUM(quantity) AS quantity, SUM(subtotal) AS revenue FROM order_history
 GROUP BY MONTH, product_id, product_name
 HAVING DATE_PART('MONTH', order_date)=<MONTH>
 ORDER BY revenue DESC
 LIMIT 10;
```

### Smaple Output for October

| Month | Name                | Quantity | Revenue |
| ----- | ------------------- | -------- | ------- |
| 10    | Smartphone X        | 5        | 4499.95 |
| 10    | Laptop Pro          | 3        | 3899.97 |
| 10    | Tablet Ultra        | 3        | 1649.97 |
| 10    | Smartwatch Pro      | 4        | 1119.96 |
| 10    | Vacuum Robot        | 2        | 599.98  |
| 10    | Wireless Headphones | 4        | 449.97  |
| 10    | 4K Monitor          | 1        | 399.99  |
| 10    | Winter Jacket       | 3        | 299.98  |
| 10    | Mechanical Keyboard | 2        | 259.98  |
| 10    | Coffee Maker Pro    | 3        | 239.98  |

---

## SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month (Include customer names and their total order amounts).

```sql

SELECT CONCAT(C.first_name, ' ', C.last_name) AS full_name, SUM(O.total_amount) AS total_amount FROM
customer C JOIN orders O ON C.customer_id = O.customer_id
GROUP BY name, DATE_PART('month', O.order_date)
HAVING SUM(O.total_amount) > 500 AND  DATE_PART('month', O.order_date) = DATE_PART('MONTH', CURRENT_DATE) - Interval
ORDER BY total_amount DESC;
```

### Same result but getting the benifit of denormalization we applied erlier.

```sql
SELECT customer_full_name AS full_name, SUM(total_amount) total_amount FROM order_history
GROUP BY full_name, DATE_PART('month', order_date)
HAVING SUM(total_amount) > 500 AND  DATE_PART('month', order_date) = DATE_PART('MONTH', CURRENT_DATE) - Interval
ORDER BY total_amount DESC;
```

### Smaple Output

| Full Name        | Total Amount |
| ---------------- | ------------ |
| John Smith       | 3789.94      |
| Sarah Johnson    | 2759.79      |
| Robert Miller    | 2394.92      |
| Emily Brown      | 2138.92      |
| Linda Thomas     | 1064.97      |
| William Wilson   | 869.90       |
| James Martinez   | 819.94       |
| David Jones      | 774.85       |
| Michael Williams | 679.85       |
| Lisa Garcia      | 559.90       |

---

## SQL query to search for all products containing a certain keyword in either the product name or description.

```sql
SELECT name, Description FROM Product
WHERE name ILIKE '%' || keyword || '%'
   OR Description ILIKE '%' || keyword || '%'
```

> ⚠️ **Note:** This query performs a sequential scan because the pattern starts with a wildcard (%).
> Although it works correctly, it may become slow on large tables.
> This will optimized later on.

### Alternative way of searching for keyword in POSTGRESQL

```sql
ALTER TABLE PRODUCT ADD COLUMN SEARCH_VECTOR TSVECTOR
GENERATED ALWAYS AS (TO_TSVECTOR('english', name||' '||description)) stored;

CREATE INDEX IDX_FULL_TEXT_SEARCH ON PRODUCT USING GIN (SEARCH_VECTOR);

EXPLAIN ANALYSE
SELECT product_id, name, description FROM PRODUCT WHERE SEARCH_VECTOR @@ TO_TSQUERY('fit');

```

- Creating a column combines the fields we need to search in.
- Creating a **GIN** (Generated Inverted Index) which is the most prefered for **Full Text Search**.
- > We might create an index over the **ts_vector** expression but for this way we must use the same expression to search for text, however, denormalization could be beneficial sometimes.

---

## Query to suggest popular products in the same category, excluding the Purchased products by the current customer from the recommendations.

```SQL
SELECT product_id, name, description, category_id FROM product
WHERE product_id NOT IN
(SELECT Product_ID FROM order_history WHERE customer_id = <customer_id>)
AND category_id IN
(SELECT category_id FROM order_history WHERE customer_id = <cusotmer_ID>)
```

---

## Procedure with transaction to create new order.

```sql
CREATE OR REPLACE PROCEDURE SP_NEW_ORDER(
P_CUSTOMER_ID INT,
P_PRODUCTS JSONB
)

LANGUAGE PLPGSQL
AS $$
DECLARE
V_ORDER_ID INT;
V_TOTAL NUMERIC:=0;
V_STOCK INT;
V_ITEM RECORD;
V_PRICE NUMERIC;
BEGIN
	-- CHECKS FOR CUSTOMER EXISTENCE (EDGE CASE FOR DATABASE ACCESS).
	PERFORM 1 FROM CUSTOMER WHERE CUSTOMER_ID=P_CUSTOMER_ID;
	IF NOT FOUND THEN RAISE EXCEPTION 'CUSTOMER NOT FOUND'; END IF;

	-- CREATING THE NEW ORDER (LOCKING THE NEW ROW UNTILL THE TRANSACTION COMMITS) AND RECIEVING THE NEW ORDER_ID
	INSERT INTO orders (customer_id,order_date,total_amount)
	VALUES (P_CUSTOMER_ID, CURRENT_TIMESTAMP,1) RETURNING ORDER_ID INTO V_ORDER_ID;

	-- Looping over the products input.
	FOR V_ITEM IN SELECT PRODUCT_ID, QUANTITY FROM JSONB_TO_RECORDSET(P_PRODUCTS) AS (PRODUCT_ID INT,QUANTITY INT) LOOP

	IF V_ITEM.QUANTITY < 1 THEN RAISE EXCEPTION 'INVALID ORDER QUANTITY.'; END IF;

	SELECT PRICE, STOCK_QTY INTO V_PRICE,V_STOCK FROM PRODUCT WHERE PRODUCT_ID =V_ITEM.PRODUCT_ID FOR UPDATE;
	IF NOT FOUND THEN RAISE EXCEPTION 'PRODUCT NOT FOUND.'; END IF;

	IF V_ITEM.QUANTITY > V_STOCK THEN RAISE EXCEPTION 'LOW STOCK QUANTITY.'; END IF;

	-- for each product in the order there is a row in the order_details table.
	INSERT INTO order_details(ORDER_ID,PRODUCT_ID,QTY,UNIT_PRICE)
	VALUES(V_ORDER_ID, V_ITEM.PRODUCT_ID, V_ITEM.QUANTITY, V_PRICE);

	UPDATE PRODUCT SET STOCK_QTY = STOCK_QTY - V_ITEM.QUANTITY WHERE PRODUCT_ID= V_ITEM.PRODUCT_ID;
	V_TOTAL := V_TOTAL + (V_PRICE*V_ITEM.QUANTITY);
	END LOOP;

	-- Updating the total amount of the order
	UPDATE ORDERS SET TOTAL_AMOUNT=V_TOTAL WHERE ORDER_ID = V_ORDER_ID;
END;
$$;
```

---

## Trigger automatically generates a order history record after insertion in (Order_Details) table.

```sql
CREATE OR REPLACE FUNCTION FN_CREATE_ORDER_HISTORY_AFTER_ORDER_DETAILS_INERTION()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
  -- INSERTING TOTAL_AMOUNT = 1 BECOUSE THE TOTAL AMOUNT IS NOT YET CALCULATED IN THE TRANSACTION.
	INSERT INTO order_history(order_id, product_id, category_id, customer_id, customer_full_name, total_amount, order_date,product_name, subtotal, quantity)
	SELECT NEW.ORDER_ID, NEW.PRODUCT_ID, P.CATEGORY_ID, C.CUSTOMER_ID, C.FIRST_NAME || ' ' || C.LAST_NAME AS CUSTOMER_FULL_NAME
	, 1, O.ORDER_DATE, P.NAME, (NEW.QTY*NEW.UNIT_PRICE) AS SUBTOTAL, NEW.QTY
	FROM PRODUCT P, ORDERS O JOIN CUSTOMER C ON C.CUSTOMER_ID=O.CUSTOMER_ID
	WHERE P.PRODUCT_ID=NEW.PRODUCT_ID AND O.ORDER_ID = NEW.ORDER_ID;
	RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER TG_AFTER_INSERT_ORDER_DETAILS
AFTER INSERT ON ORDER_DETAILS
FOR EACH ROW
EXECUTE FUNCTION FN_CREATE_ORDER_HISTORY_AFTER_ORDER_DETAILS_INSERTION();
```

---

## Trigger automatically updates total_amount column in order history table after the (total_amount) column in (orders) table is updated.

```sql
CREATE OR REPLACE FUNCTION FN_UPDATE_ORDER_HISTORY_TOTAL_AFTER_ORDER_UPDATE()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
	UPDATE ORDER_HISTORY SET TOTAL_AMOUNT = NEW.TOTAL_AMOUNT WHERE ORDER_ID=NEW.ORDER_ID;
	RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER TR_AFTER_TOTAL_AMOUNT_UPDATE
AFTER UPDATE OF TOTAL_AMOUNT ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION FN_UPDATE_ORDER_HISTORY_TOTAL_AFTER_ORDER_UPDATE();
```

> **NOTE:** This trigger completes the **TG_AFTER_INSERT_ORDER_DETAILS** both of them are fired within the same transaction.

---

## Transaction query to lock the field quantity for a gevin product_id from being updated.

```sql
BEGIN;
SELECT product_id FROM product WHERE product_id= <product_id> FOR UPDATE;
COMMIT;
```

---

## Transaction query to lock row for a gevin product_id from being updated.

```sql
BEGIN;
SELECT * FROM product WHERE product_id= <product_id> FOR UPDATE;
COMMIT;
```

---

## POSTGRESQL Performance Tuning

### SQL Query to Retrieve the total number of products in each category.

```sql
 EXPLAIN ANALYZE
    SELECT category.category_name FROM category JOIN (
SELECT category_id, count(1) FROM product
GROUP BY category_id) E ON category.category_id=E.category_id;

```

> Using the subquery to minimize the number of rows that will be joined as demonstraited in the plan the join is the last operation
> means that we only joining the desired ouput no elemenations after the hashing.

#### Initial Execution Plan

    Hash Join  (cost=107078.94..109349.37 rows=100000 width=14) (actual time=541.430..574.992 rows=99900.00 loops=1)
      Hash Cond: (product.category_id = category.category_id)
      Buffers: shared hit=2209 read=49914
      ->  Finalize HashAggregate  (cost=104191.94..105195.44 rows=100350 width=12) (actual time=480.164..491.945 rows=99900.00 loops=1)
            Group Key: product.category_id
            Batches: 1  Memory Usage: 6681kB
            Buffers: shared hit=1572 read=49914
            ->  Gather  (cost=78502.34..103589.84 rows=240840 width=4) (actual time=406.953..432.692 rows=299700.00 loops=1)
                  Workers Planned: 2
                  Workers Launched: 2
                  Buffers: shared hit=1572 read=49914
                  ->  Partial HashAggregate  (cost=77502.34..78505.84 rows=100350 width=4) (actual time=392.141..401.784 rows=99900.00 loops=3)
                        Group Key: product.category_id
                        Batches: 1  Memory Usage: 4633kB
                        Buffers: shared hit=1572 read=49914
                        Worker 0:  Batches: 1  Memory Usage: 6681kB
                        Worker 1:  Batches: 1  Memory Usage: 4633kB
                        ->  Parallel Seq Scan on product  (cost=0.00..72299.07 rows=2081307 width=4) (actual time=0.108..88.496 rows=1665000.00 loops=3)
                              Buffers: shared hit=1572 read=49914
      ->  Hash  (cost=1637.00..1637.00 rows=100000 width=18) (actual time=61.148..61.148 rows=100000.00 loops=1)
            Buckets: 131072  Batches: 1  Memory Usage: 6102kB
            Buffers: shared hit=637
            ->  Seq Scan on category  (cost=0.00..1637.00 rows=100000 width=18) (actual time=30.169..39.480 rows=100000.00 loops=1)
                  Buffers: shared hit=637
    Planning Time: 0.349 ms
    JIT:
      Functions: 39
      Options: Inlining false, Optimization false, Expressions true, Deforming true
      Timing: Generation 3.722 ms (Deform 1.601 ms), Inlining 0.000 ms, Optimization 1.763 ms, Emission 38.017 ms, Total 43.502 ms
    Execution Time: 582.141 ms
    (30 rows)

[Visual Tree representation for the plan](https://explain.dalibo.com/plan/cecg6ea5883f6bfg)

- Since **_POSTGRES_** do not automatically create foreign key index, the optimizer choose to go ahead with sequentianl scan (full table scan) on products.

#### After Optimizatino

- Creating index on Product(Category_id) the category id foreign key in the products table

```sql
CREATE INDEX idx_product_category_id ON product(category_id);
ANALYZE product;
```

    Hash Join  (cost=97982.96..99882.47 rows=98934 width=14) (actual time=229.386..250.224 rows=99900.00 loops=1)
      Hash Cond: (category.category_id = e.category_id)
      Buffers: shared hit=204783
      ->  Seq Scan on category  (cost=0.00..1637.00 rows=100000 width=18) (actual time=0.027..4.906 rows=100000.00 loops=1)
            Buffers: shared hit=637
      ->  Hash  (cost=96746.28..96746.28 rows=98934 width=4) (actual time=229.200..229.274 rows=99900.00 loops=1)
            Buckets: 131072  Batches: 1  Memory Usage: 4537kB
            Buffers: shared hit=204146
            ->  Subquery Scan on e  (cost=94767.60..96746.28 rows=98934 width=4) (actual time=204.716..219.670 rows=99900.00 loops=1)
                  Buffers: shared hit=204146
                  ->  Finalize HashAggregate  (cost=94767.60..95756.94 rows=98934 width=12) (actual time=204.715..214.231 rows=99900.00 loops=1)
                        Group Key: product.category_id
                        Batches: 1  Memory Usage: 6681kB
                        Buffers: shared hit=204146
                        ->  Gather  (cost=1000.43..94174.00 rows=237442 width=4) (actual time=0.670..186.933 rows=99900.00 loops=1)
                              Workers Planned: 2
                              Workers Launched: 2
                              Buffers: shared hit=204146
                              ->  Partial GroupAggregate  (cost=0.43..69429.80 rows=98934 width=4) (actual time=0.067..181.687 rows=33300.00 loops=3)
                                    Group Key: product.category_id
                                    Buffers: shared hit=204146
                                    ->  Parallel Index Only Scan using idx_product_category_id on product  (cost=0.43..63237.19 rows=2081307 width=4) (actual time=0.043..100.594 rows=1665000.00 loops=3)
                                          Heap Fetches: 0
                                          Index Searches: 1
                                          Buffers: shared hit=204146
    Planning:
      Buffers: shared hit=38
    Planning Time: 0.692 ms
    Execution Time: 253.437 ms
    (29 rows)

[Visual Tree representation for the plan](https://explain.dalibo.com/plan/caba29403h0e8d70)

- The total time is less than half the time without the index
- As we can see the optimizer choose to go with group aggregate
  - Since it does index scan the data is sorted, best suited for group aggregate (Much more effecient than hash aggregate) since we are passing the hashing cost here
    means less time and less memory (memory buckets).

### SQL Query to Retrieve the most recent 1000 orders orders with customer information.

```sql
EXPLAIN ANALYZE
    SELECT c.customer_id, c.first_name, c.last_name, order_date  FROM customer c JOIN (
        SELECT o.customer_id, o.order_date FROM orders o
                                           ORDER BY order_date DESC LIMIT 1000
    ) o ON c.customer_id = o.customer_id;

```

#### Initial Execution Plan (Query is optimized but the performace is not optimal)

    Nested Loop  (cost=368009.37..370253.65 rows=1000 width=33) (actual time=579.044..611.587 rows=1000.00 loops=1)
      Buffers: shared hit=6389 read=96917
      ->  Limit  (cost=368008.93..368125.39 rows=1000 width=8) (actual time=579.002..579.308 rows=1000.00 loops=1)
            Buffers: shared hit=2822 read=96484
            ->  Gather Merge  (cost=368008.93..1522577.59 rows=9913313 width=8) (actual time=573.226..573.471 rows=1000.00 loops=1)
                  Workers Planned: 2
                  Workers Launched: 2
                  Buffers: shared hit=2822 read=96484
                  ->  Sort  (cost=367008.90..377335.27 rows=4130547 width=8) (actual time=561.299..561.343 rows=888.67 loops=3)
                        Sort Key: o.order_date DESC
                        Sort Method: top-N heapsort  Memory: 88kB
                        Buffers: shared hit=2822 read=96484
                        Worker 0:  Sort Method: top-N heapsort  Memory: 88kB
                        Worker 1:  Sort Method: top-N heapsort  Memory: 88kB
                        ->  Parallel Seq Scan on orders o  (cost=0.00..140535.47 rows=4130547 width=8) (actual time=13.221..246.945 rows=3300000.00 loops=3)
                              Buffers: shared hit=2746 read=96484
      ->  Memoize  (cost=0.44..8.29 rows=1 width=29) (actual time=0.032..0.032 rows=1.00 loops=1000)
            Cache Key: o.customer_id
            Cache Mode: logical
            Hits: 0  Misses: 1000  Evictions: 0  Overflows: 0  Memory Usage: 128kB
            Buffers: shared hit=3567 read=433
            ->  Index Scan using customer_pkey on customer c  (cost=0.43..8.28 rows=1 width=29) (actual time=0.032..0.032 rows=1.00 loops=1000)
                  Index Cond: (customer_id = o.customer_id)
                  Index Searches: 1000
                  Buffers: shared hit=3567 read=433
    Planning:
      Buffers: shared hit=24
    Planning Time: 0.665 ms
    JIT:
      Functions: 17
      Options: Inlining false, Optimization false, Expressions true, Deforming true
      Timing: Generation 1.879 ms (Deform 0.824 ms), Inlining 0.000 ms, Optimization 1.327 ms, Emission 9.052 ms, Total 12.258 ms
    Execution Time: 613.422 ms

- Since There is no index on the Order date the there will be over head sorting the orders by date.
  [Visual Tree representation for the plan](https://explain.dalibo.com/plan/44a143d8a0a4d58c)

##### After Optimization

- Creating index on orders(customer_id) Customer's Foreign key in the orders table.
- Creating index on orders(order_date) **means the data will be sorted which means the engine will scan the index Backward**.

```sql
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);
ANALYZE orders;
```

    Nested Loop  (cost=0.88..2250.75 rows=1000 width=33) (actual time=0.060..6.960 rows=1000.00 loops=1)
      Buffers: shared hit=4971
      ->  Limit  (cost=0.43..56.31 rows=1000 width=8) (actual time=0.028..1.235 rows=1000.00 loops=1)
            Buffers: shared hit=971
            ->  Index Scan Backward using idx_order_date on orders o  (cost=0.43..551094.66 rows=9862939 width=8) (actual time=0.026..1.080 rows=1000.00 loops=1)
                  Index Searches: 1
                  Buffers: shared hit=971
      ->  Memoize  (cost=0.44..8.29 rows=1 width=29) (actual time=0.005..0.005 rows=1.00 loops=1000)
            Cache Key: o.customer_id
            Cache Mode: logical
            Hits: 0  Misses: 1000  Evictions: 0  Overflows: 0  Memory Usage: 128kB
            Buffers: shared hit=4000
            ->  Index Scan using customer_pkey on customer c  (cost=0.43..8.28 rows=1 width=29) (actual time=0.004..0.004 rows=1.00 loops=1000)
                  Index Cond: (customer_id = o.customer_id)
                  Index Searches: 1000
                  Buffers: shared hit=4000
    Planning:
      Buffers: shared hit=8
    Planning Time: 0.533 ms
    Execution Time: 7.092 ms

[Visual Tree representation for the plan](https://explain.dalibo.com/plan/357a865529cf84eg)

- The engine scans 1000 record using the idx_order_date backward.
- Stores the outpu in memory.
- Scans the Customer_pkey index searching only for the 1000 record (output which is memoized).

#### Final Conclusion

- From what is obvious here by creating these indices.
  - We eleminated (parallel sequence scan, sorting,merging the work make by two workers)
  - We also reduced (CPU usage, disk access, memory usage).
- Reduced the execution time more than 500 MS.

## MYSQL Query optimization

### Practice table

```sql
create table userInfo
(
    id              int unsigned auto_increment
        primary key,
    name            varchar(64)       default ''  not null,
    email           varchar(64)       default ''  not null,
    password        varchar(64)       default ''  not null,
    dob             date                          null,
    address         varchar(255)      default ''  not null,
    city            varchar(64)       default ''  not null,
    state_id        smallint unsigned default 0 not null,
    zip             varchar(8)        default ''  not null,
    country_id      smallint unsigned default 0 not null,
    account_type    varchar(32)       default ''  not null,
    closest_airport varchar(3)        default ''  not null,
    constraint email
        unique (email)
);

```

- Populating the table with more than 6M record for testing.

### Benchmark procedure for testing

```sql
 DELIMITER $$
 CREATE PROCEDURE benchmark_userinfo()
 BEGIN
     DECLARE i INT DEFAULT 0;
     DECLARE nb_of_requests INT DEFAULT 300;
     DECLARE start_time DATETIME(6);
     DECLARE end_time DATETIME(6);
     DECLARE total_seconds DOUBLE;
     DECLARE qps DOUBLE;
     DECLARE RESULT BIGINT;


     -- Start timer
     SET start_time = NOW(6);

     WHILE i < nb_of_requests DO
         SELECT COUNT(*) INTO RESULT
         FROM userInfo
         WHERE `name` = 'Jhon100'
           AND `state_id` = 100;

         SET i = i + 1;
     END WHILE;

     -- End timer
     SET end_time = NOW(6);

     -- Time in seconds
     SET total_seconds =
         TIMESTAMPDIFF(MICROSECOND, start_time, end_time) / 1000000;

     -- QPS
     SET qps = nb_of_requests / total_seconds;

     -- Output
     SELECT
         nb_of_requests AS total_queries,
         total_seconds AS total_time_seconds,
         qps AS queries_per_second;
 END$$
 DELIMITER ;
```

- This benchmark procedure runs 300 times and calculates the (start time, end time, query per secon);

#### The Query

```sql
SELECT COUNT(*) FROM userInfo WHERE name = <name> AND status_id = <status_id>;
```

### 1. Benchmark results without index

| TOTAL QUERIES | TOTAL_TIME_SECONDS | QUERIES_PER_SECOND |
| 300 | 626.176728 | 0.47909797120406555 |

- This is a full table sequence scan which is catastrophic, it's obvious no need for the execution plan

### 2. Benchmark results after creating separate indexes on (name state_id) columns.

| TOTAL QUERIES | TOTAL_TIME_SECONDS | QUERIES_PER_SECOND |
| ------------- | ------------------ | ------------------ |
| 300           | 0.066881           | 4485.5788639523935 |

#### Query Analyses results

    -> Aggregate: count(0)
    (cost=5.37 rows=1)
    (actual time=0.135..0.135 rows=1 loops=1)

        -> Filter: ((userInfo.state_id = 100)
                    AND (userInfo.name = 'Jhon100'))
          (cost=5.27 rows=1)
          (actual time=0.0414..0.13 rows=100 loops=1)

            -> Intersect rows sorted by row ID
              (cost=5.27 rows=1)
              (actual time=0.0398..0.114 rows=100 loops=1)

                -> Index range scan on userInfo
                  using idx_name over (name = 'Jhon100')
                  (cost=4.09 rows=100)
                  (actual time=0.0198..0.06 rows=100 loops=1)

                -> Index range scan on userInfo
                  using idx_state_id over (state_id = 100)
                  (cost=1.07 rows=100)
                  (actual time=0.0189..0.0448 rows=100 loops=1)

#### The problem of having two separate index makes the database (MERGE INDEXES)

1- Scan the first index.
2- Scan the second index.
3- Sort both results by id.
4- Intersect the results based on id.

- NOTE: in the intersect operation the number of rows is not estimated correctly which also a problem.
  5- Filter the resalts again.

### 3. Benchmark results after creating composite indexes on (name, state_id) The best choice.

| TOTAL QUERIES | TOTAL_TIME_SECONDS | QUERIES_PER_SECOND |
| ------------- | ------------------ | ------------------ |
| 300           | 0.03046            | 9848.98227183191   |

#### Query Analyses results

    -> Aggregate: count(0)
    (cost=24.1 rows=1)
    (actual time=0.051..0.0511 rows=1 loops=1)

        -> Covering index lookup on userInfo
          using name_state_id_idx
          (name = 'Jhon100', state_id = 100)
          (cost=14.1 rows=100)
          (actual time=0.0156..0.0459 rows=100 loops=1)

- The queries per second is doubled -> this is half the operations done by the (MERGE INDEX) plan and the number of rows are estimated correctly.

---

## Index Performance

- Reduce the rows examined
  - Creating index can intensively reduce the number of rows scanned by **WHERE** or **JOIN**.
- Sorting Data
  - BTree indexes can read the data in the order the query needs
    - Assuming we have this query
    ```sql
      SELECT * FROM userInfo ORDER BY state_id DESC LIMIT 10;
    ```
    - Without the index this will be a full table scan then sorts the result and get the records we want.
    - But with index it will just read the records in reverse order.
- Validating Data (Adding unique index).
- Avoid reading rows using covering indexes.
- Getting the **MIN** and **MAX** values by only checking the first and last records in the index.

## When to add or remove an index

### IN MYSQL we have two main views to find statistics with full table scan

```sql
-- The first view is
-- Schema tables with full table scans: Shows the rows that a query executed with full table scan
SELECT * FROM schema_tables_with_full_table_scans;

-- The second view
-- Statements with full table scans: Show the statements executed with full table table scan (ordered by the time of execution)
SELECT * FROM statements_with_full_table_scans;

```

- They give you a good insight on wheather you need to create new index or not.

### When should we remove an index

- We have two schemas that might help us to make a decision

```sql
-- The first one is
-- schema unused indexes: Show the indexes that are no longer used or never used at all.
SELECT * FROM schema_unused_indexes;

-- The second one is
-- schema redundant indexes: Shows the redundant indexes
SELECT * FROM schema_redundant_indexes;
```

### Rdundant Indexs

- Let assume we have an index on cols (name, email)
- Another index on (email) **_not the same_** **_not redundant_**
- Another on (email, name) **_not the same_** **_not redundant_**
- Having indexes from different type such as (hash, full text) are **_not redundant_**
- Having index (name, id PK) it is the same since the PK index is already appended to any secondary index leaf nood.
  - They might be beneficial in **ORDER BY** clauses.
- Another on (name) **_same_** **_redundant_**
  - In some cases it might make sense to keep it that way.
  - It depends on how frequent we use the index and the number of times the data of the table will be changed.

### Index Statistics

> Secondary indexes are not in the same order such as the data.

- When we use a secondary index for searching means there will be extra primary key lookup to reach the data witch means a random I/O.
  - InnoDB calculates index statistics by randomly analyze the leaf pages which is scaled based on the index total size
  - The more pages it analyze the more accurate statistics we get but also the higher the cost
    > **NOTE**: The more pages we add the more index analysis time we get (which run when more than 10% of the data changed)
- The number of sample pages could be changed using

```sql
ALTER TABLE table_name stats_smaple_pages = <number_of_pages>;
```

## **Contact**

For questions or feedback:

- GitHub: [@AbdallaSamirKhalifa](https://github.com/AbdallaSamirKhalifa)
- Email: abdallasamirkhalifa@gmail.com
- Linkedin: [Abdalla Khalifa](linkedin.com/in/abdalla-khalifa)
