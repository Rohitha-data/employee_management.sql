# Employee Management System (PostgreSQL)

## Project Overview
The **Employee Management System** is a relational database project implemented in PostgreSQL.  
It simulates a small HR management system with **Employees** and **Departments** tables and demonstrates SQL concepts such as joins, aggregations, filtering, and CTEs.

This project is designed for learning and showcasing SQL skills, allowing users to:
- Track employees and their departments  
- Analyze salary data  
- Identify top-performing or high-paid employees  
- Generate reports for departments  

It is suitable for **portfolio use** as it demonstrates real-world business scenarios and SQL query skills.

---

## Tables

### 1. Departments
| Column    | Type    | Description                  |
|-----------|---------|------------------------------|
| dept_id   | SERIAL  | Primary Key                  |
| dept_name | VARCHAR | Name of the department       |

### 2. Employees
| Column    | Type     | Description                             |
|-----------|----------|-----------------------------------------|
| emp_id    | SERIAL   | Primary Key                             |
| emp_name  | VARCHAR  | Employee name                           |
| dept_id   | INT      | Foreign key referencing Departments     |
| salary    | NUMERIC  | Employee salary                         |
| hire_date | DATE     | Date of joining                         |

---

## Sample Queries

1. **List all employees with their department**

SELECT e.emp_name, d.dept_name, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;


2.Highest-paid employee per department

SELECT DISTINCT ON (d.dept_id) d.dept_name, e.emp_name, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_id, e.salary DESC;

3.Average salary per department

SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

4.Employees hired after 2020

SELECT emp_name, hire_date
FROM Employees
WHERE hire_date > '2020-01-01';

5.Employees earning above department average (Advanced Query)

WITH dept_avg AS (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY dept_id
)
SELECT e.emp_name, d.dept_name, e.salary, da.avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
JOIN dept_avg da ON e.dept_id = da.dept_id
WHERE e.salary > da.avg_salary;

6.Count of employees per department (Advanced Query)


SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

## How to Run
1. Open PostgreSQL (pgAdmin, DBeaver, or psql).  
2. Open `employee_management.sql` in your SQL editor.  
3. Run the script to create tables, insert sample data, and execute queries.  
4. Explore the sample queries in the README or modify data to practice SQL skills.
