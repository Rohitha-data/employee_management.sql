CREATE TABLE Departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT REFERENCES Departments(dept_id),
    salary NUMERIC(10,2),
    hire_date DATE
);

INSERT INTO Departments (dept_name) VALUES
('HR'),
('IT'),
('Sales');

SELECT * FROM Departments ;

INSERT INTO Employees (emp_name, dept_id, salary, hire_date) VALUES
('Alice', 1, 50000, '2020-01-10'),
('Bob', 2, 70000, '2019-03-15'),
('Charlie', 2, 65000, '2021-07-20'),
('David', 3, 60000, '2018-11-05'),
('Eva', 3, 72000, '2020-09-12');

SELECT * FROM Employees;

-- 1. List all employees with their department
SELECT e.emp_name, d.dept_name, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_name;

-- 2. Highest-paid employee per department
SELECT DISTINCT ON (d.dept_id) d.dept_name, e.emp_name, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_id, e.salary DESC;

-- 3. Average salary per department
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- 4. Employees hired after 2020
SELECT emp_name, hire_date
FROM Employees
WHERE hire_date > '2020-01-01';

-- 5. Employees earning above department average (Advanced Query)
WITH dept_avg AS (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY dept_id
)
SELECT e.emp_name, d.dept_name, e.salary, da.avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
JOIN dept_avg da ON e.dept_id = da.dept_id
WHERE e.salary > da.avg_salary
ORDER BY d.dept_name, e.salary DESC;

-- 6. Count of employees per department (Advanced Query)
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;





