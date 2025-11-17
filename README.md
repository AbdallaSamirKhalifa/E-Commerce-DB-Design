# **E-Commerce Database Design**

This repository includes the **database design** and **SQL implementation** for an **E-Commerce Web Application**, created as a practice exercise inspired by concepts from the book **Practical Web Database Design**.

> ⚠️ **Note:** This project is currently under development. The database schema and other components are subject to change.

---

## **Motivation**

This project is part of a mentorship program aimed at strengthening our **technical** and **interpersonal** skills to prepare for real-world market requirements.

---

## **Table of Contents**

- [Motivation](#motivation)
- [What's Included](#whats-included)
- [How to Browse](#how-to-browse)
- [ERD](#erd)
- [Relational Schema](#schema)

---

## **What's Included**

- **Entity-Relationship Diagram (ERD)**.
- **Relational Schema**.
- **Normalization**
- **Denormalization**
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
