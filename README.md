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

- The **Order_History** table stores customer names ,total amounts, products informations and their subtotal directly, even though this data also exists in other tables.  
  This avoids expensive joins when generating historical order summaries, this might slower the creating new order process but it could be fixed with a **background task** or **batch task** that runs once or twice a week to avoid this problem.
- Product pricing at the moment of purchase is copied into **Order_Details (Unit_Price)** to preserve price history, even if the product price changes later.

These denormalizations are chosen on purpose for practical advantages in analytics, reporting, and historical accuracy, while keeping the overall schema clear and maintainable.

---

<h2 align="center" id="DDL">Schema DDL</h2>

```sql

CREATE DATABASE E_Commerce

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
Order_ID INT PRIMARY KEY,
Customer_ID INT NOT NULL,
Customer_Full_Name VARCHAR(40) NOT NULL,
Total_Amount DECIMAL(9,2) NOT NULL CHECK(Total_Amount > 0),
Order_Date TIMESTAMP NOT NULL,
Products JSONB
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
HAVING DATE(order_date) = date;
```

### Smaple Output

| month      | Revenue |
| ---------- | ------- |
| 2024-11-03 | 699.92  |

---

## SQL query to generate a monthly report of the top-selling products in a given month.

```sql
SELECT DATE_PART('MONTH', O.order_date) AS month, P.Name, SUM(OD.qty) AS quantity, SUM(OD.unit_price) AS revenue FROM product P
 JOIN order_details OD ON OD.product_id = P.product_id
 JOIN orders O ON OD.order_id = O.order_ID
 GROUP BY name,month
 HAVING DATE_PART('MONTH', O.order_date) = '10'
 ORDER BY revenue DESC
 LIMIT 10;
```

### Smaple Output

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

## ## SQL query to search for all products containing a certain keyword in either the product name or description.

```sql
SELECT name, Description FROM Product
WHERE name ILIKE '%' || keyword || '%'
   OR Description ILIKE '%' || keyword || '%'
```

⚠️ **Note:** This query performs a sequential scan because the pattern starts with a wildcard (%).
Although it works correctly, it may become slow on large tables.
This will optimized later on.

---

## **Contact**

For questions or feedback:

- GitHub: [@AbdallaSamirKhalifa](https://github.com/AbdallaSamirKhalifa)
- Email: abdallasamirkhalifa@gmail.com
