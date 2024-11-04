DROP TABLE IF EXISTS departments; 

CREATE TABLE departments(
	dept_no CHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(40) NOT NULL
);

SELECT * FROM departments;

------------------------------------------

DROP TABLE IF EXISTS dept_manager;

CREATE TABLE dept_manager(
	dept_no CHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM dept_manager;

------------------------------------------

DROP TABLE IF EXISTS dept_emp;

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no CHAR(4) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp;

--------------------------------------------

DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(40) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	sex CHAR NOT NULL,
	hire_date DATE NOT NULL
);

SELECT * FROM employees;
----------------------------------------

DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries(
	emp_no INT PRIMARY KEY NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;
----------------------------------------

DROP TABLE IF EXISTS titles;

CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY NOT NULL,
	title VARCHAR NOT NULL
);

SELECT * FROM titles;
---------------------------------------
SELECT emp_no, last_name, first_name, sex
FROM employees;

SELECT salary from salaries;

SELECT e. emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;
-----------------------------------------
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE EXTRACT(YEAR FROM e.hire_date) = 1986;
------------------------------------------------
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, t.title
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no
JOIN titles t ON e.emp_title_id = t.title_id;
-----------------------------------------------------
SELECT d.dept_no, dm.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;
---------------------------------------------------
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'AND last_name LIKE 'B%';
----------------------------------------------------
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';
---------------------------------------------------------------
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');
---------------------------------------------------------
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;