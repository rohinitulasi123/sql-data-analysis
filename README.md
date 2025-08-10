## Overview
This project is part of my Data Analyst internship tasks.  
It involves creating a sample **Ecommerce SQL database**, running various SQL queries, and analyzing the results.

---

## Tools Used
- MySQL Server & MySQL Workbench
- Dataset: Sample ecommerce data (customers, products, orders)

---

## Files in this Repository
- **ecommerce.sql** — database creation, sample data, and queries.
- **/screenshots/** — output screenshots of all queries.
- **README.md** — documentation of the task and answers to interview questions.

---

## Queries & Outputs
1. Customers from India — `01_customers_india.png`
2. Total revenue per product — `02_total_revenue.png`
3. Inner join: full order details — `03_inner_join.png`
4. Left join: customers with/without orders — `04_left_join.png`
5. Subquery: customers who spent more than 500 — `05_spent_gt_500.png`
6. Average revenue per user — `06_avg_revenue.png`
7. View: top spending customers — `07_top_spending_customers.png`
8. Handling NULLs in email — `08_null_handling.png`

---

## Interview Q&A
1. **WHERE vs HAVING** — WHERE filters rows before aggregation; HAVING filters after aggregation (on grouped data).
2. **Types of Joins** — INNER, LEFT, RIGHT, FULL OUTER (some DBs), CROSS.
3. **Average Revenue per User in SQL** — `SUM(revenue)/COUNT(DISTINCT customer_id)`.
4. **Subqueries** — A query inside another query, can return scalar, row, or table results.
5. **Optimizing SQL Queries** — Use indexes, avoid SELECT *, filter early, use proper joins.
6. **View in SQL** — A saved query treated as a virtual table for reuse.
7. **Handling NULLs** — Use `COALESCE()` or `IFNULL()` to replace null values.

---

## How to Run
1. Open **MySQL Workbench** and connect to your MySQL server.
2. Open `ecommerce.sql` and execute all commands.
3. Run each SELECT query individually to verify the results.
4. Compare your outputs with the screenshots provided.

---

## Submission
GitHub repository link: *(add your repo link here)*  
Google Form: [Submission Link](https://forms.gle/p8F9dtXF1GrHx5wU8)
