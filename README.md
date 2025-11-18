# **E-Commerce Database Design**

This repository includes the **database design** and **SQL implementation** for an **E-Commerce Web Application**, created as a practice exercise inspired by concepts from the book **Practical Web Database Design**.

> ⚠️ **Note:** This project is currently under development. The database schema and other components are subject to change.

---

## **Motivation**

This project is part of a mentorship program aimed at strengthening our **technical** and **interpersonal** skills to prepare for real-world market requirements.

---

## Project Structure

```
E-Commerce-Database/
├── README.md           # Project documentation
|── ERD.png             # Entity Relationship Diagram
|── Relational-Schema.png         # Database Schema
└── DDL_DML/
    |── Shcema.sql        # Database schema (CREATE statements)
    └── Test_Data.sql     # Sample data (INSERT statements)

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

- The **Order_History** table stores customer names and total amounts directly, even though this data also exists in other tables.  
  This avoids expensive joins when generating historical order summaries, this might slower the creating new order process but it could be fixed with a **background task** or **batch task** that runs once or twice a week to avoid this problem.
- Product pricing at the moment of purchase is copied into **Order_Details (Unit_Price)** to preserve price history, even if the product price changes later.
- Customer name fields are duplicated in **Order_History** to keep past records consistent even if the customer updates their profile.

These denormalizations are chosen on purpose for practical advantages in analytics, reporting, and historical accuracy, while keeping the overall schema clear and maintainable.

---

<h2 align="center" id="DDL">Schema DDL</h2>

```sql

CREATE DATABASE E_Commerce;

CREATE TABLE IF NOT EXISTS Category(
Category_ID INT PRIMARY KEY,
Category_Name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product(
Product_ID INT PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
Description VARCHAR(50) NOT NULL,
Price DECIMAL(7,2) NOT NULL CHECK(Price > 0),
Stock_QTY INT NOT NULL Check(Stock_QTY > 0)
);

CREATE TABLE IF NOT EXISTS  Product_Category (
Category_ID INT ,
Product_ID INT ,
PRIMARY KEY (Category_ID, Product_ID),
FOREIGN KEY (Category_ID) REFERENCES Category ,
FOREIGN KEY (Product_ID) REFERENCES Product
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
Order_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
Order_Date TIMESTAMP NOT NULL
)

```

---

---

<h2 align="center" id="test-data">Test Data</h2>

The database includes comprehensive sample data for testing and development:

- **5 Categories**: Electronics, Clothing, Books, Home & Garden, Sports
- **12 Products**: Various items with realistic prices and stock quantities
- **8 Customers**: Sample customer accounts with unique emails
- **10 Orders**: Complete order records with multiple items
- **19 Order Details**: Individual line items across all orders

All test data respects database constraints:

- ✅ Foreign key relationships
- ✅ CHECK constraints (prices > 0, quantities > 0)
- ✅ UNIQUE constraints (customer emails)
- ✅ NOT NULL constraints

📄 **View full test data**: [Test_Data.sql](./DDL_DML/Test_Data.sql)

---

## query to generate a daily report of the total revenue for a specific date.

```sql
SELECT order_date ,SUM(total_amount) FROM ORDERS
GROUP BY order_date
HAVING order_date = Some_Date;
```

---

## <h2 align="center" id="queries">Queries</h2>

## SQL query to generate a monthly report of the top-selling products in a given month.

```sql
SELECT DATE_PART('MONTH', orders.order_date) AS month, Product.Name, SUM(order_details.qty) AS quantity, SUM(order_details.unit_price) AS revenue FROM product
 JOIN order_details ON order_details.product_id = product.product_id
 JOIN orders ON order_details.order_id = orders.order_ID
 GROUP BY name, month
 HAVING DATE_PART('MONTH', orders.order_date) = given_month
 ORDER BY quantity DESC
 LIMIT 10;
```

---

## SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month (Include customer names and their total order amounts).

```sql
SELECT customer.first_name || ' ' || customer.last_name AS name, SUM(orders.total_amount) AS total_amount FROM
customer JOIN orders ON customer.customer_id = orders.customer_id
GROUP BY name, DATE_PART('MONTH', orders.order_date)
HAVING SUM(orders.total_amount) > 500 AND  DATE_PART('MONTH', orders.order_date) = DATE_PART('MONTH', CURRENT_DATE) - 1
ORDER BY total_amount DESC;
```

### Same result but getting the benifit of denormalization we applied erlier.

```sql
SELECT customer_full_name, SUM(total_amount) total_amount FROM order_history
GROUP BY customer_full_name, DATE_PART('MONTH', order_date)
HAVING SUM(total_amount) > 500 AND  DATE_PART('MONTH', order_date) = DATE_PART('MONTH', CURRENT_DATE) - 1
ORDER BY total_amount DESC;
```

---

## **Contact**

For questions or feedback:

- GitHub: [@AbdallaSamirKhalifa](https://github.com/AbdallaSamirKhalifa)
- Email: abdallasamirkhalifa@gmail.com
