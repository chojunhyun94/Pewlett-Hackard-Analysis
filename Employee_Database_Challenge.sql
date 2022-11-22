--Viewing original tables
SELECT * FROM employees;
SELECT * FROM titles;

--Doing inner join from Employees with Titles with a filter
--Saving onto retirement_titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles
ON (e.emp_no = titles.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--Using previously made retirement_titles, filter unique and sort for recent employees
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.title
INTO unique_titles
FROM retirement_titles AS e
WHERE e.to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Grabbing count for each title that is retiring
SELECT COUNT(e.title), title
INTO retiring_titles
FROM unique_titles AS e
GROUP BY title;

--Determining eligibility for mentorship
SELECT DISTINCT ON(e. emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp as d
ON (e.emp_no = d.emp_no)
INNER JOIN titles
ON (e.emp_no = titles.emp_no)
WHERE d.to_date = '9999-01-01' AND
(birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;