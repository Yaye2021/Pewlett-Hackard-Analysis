--DELIVERABLE I
--Retrieve emp_no, first_name and last_name columns from Employees table
Select emp_no, first_name, last_name
from employees

--Retrieve the title, from_date and to_date columns from the Titles table

Select title, from_date, to_date
from titles

--Create a new table 
SELECT e.emp_no,
    e.first_name,
    e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO challenge_table
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Create a unique titles table
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Number of employees who are about to retire
SELECT COUNT(first_name), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC

--DELIVERABLE II
--Retrieve emp_no, first_name and last_name and birth_date columns from Employees table
Select emp_no, first_name, last_name, birth_date
from employees

--Retrieve from_date and to_date columns from Department Employee table
Select from_date, to_date
from dept_emp

--Retrieve title column from the Titles table
Select title
from titles

--Mentorship elegibility

SELECT e.emp_no,
    e.first_name,
    e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO elegibility
FROM employees AS e
	INNER JOIN titles AS ti
		ON e.emp_no = ti.emp_no
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
INTO mentorship_eligibilty
FROM elegibility
ORDER BY emp_no, to_date DESC;

--Additional queries
--Depts
SELECT ut.first_name,
ut.last_name,
ut.title,
de.dept_no
INTO depts
FROM unique_titles as ut
INNER JOIN dept_emp as de
ON ut.emp_no = de.emp_no
ORDER BY de.emp_no;

SELECT d.first_name,
d.last_name,
d.title,
d.dept_no,
de.dept_name
--INTO depts1
FROM depts as d
INNER JOIN departments as de
ON d.dept_no = de.dept_no
ORDER BY de.dept_no;

SELECT COUNT(first_name), dept_name
--INTO retiring_depts
FROM depts1
GROUP BY dept_name
ORDER BY COUNT DESC

--Depts
SELECT me.first_name,
me.last_name,
me.title,
de.dept_no
INTO deptsME
FROM mentorship_eligibilty AS me
INNER JOIN dept_emp as de
ON me.emp_no = de.emp_no
ORDER BY de.emp_no;

SELECT dm.first_name,
dm.last_name,
dm.title,
dm.dept_no,
de.dept_name
INTO depts2
FROM deptsME as dm
INNER JOIN departments as de
ON dm.dept_no = de.dept_no
ORDER BY de.dept_no;


SELECT COUNT(first_name), dept_name
--INTO retiring_depts
FROM depts2
GROUP BY dept_name
ORDER BY COUNT DESC

SELECT COUNT(title) FROM depts2;
