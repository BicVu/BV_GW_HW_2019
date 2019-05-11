-- 1. List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.
select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees 
inner join salaries
on employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.
-- DO NOT USE "" double quotes
select last_name, first_name, hire_date
from employees
where hire_date between '1986/01/01' and '1986/12/31';

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
from dept_manager
	inner join departments
		on dept_manager.dept_no = departments.dept_no
		inner join employees
			on dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
create view whole_dept as
select dept_emp.emp_no, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date, departments.dept_name
from dept_emp
inner join departments
on dept_emp.dept_no = departments.dept_no;

create view whole_dept_emp as
select whole_dept.emp_no, employees.last_name, employees.first_name, whole_dept.dept_name
from whole_dept
inner join employees
on whole_dept.emp_no = employees.emp_no;

-- some repeats with employees who have worked in mulitple depts
select * from whole_dept_emp limit 50;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name 
from employees
where first_name = 'Hercules'
and last_name like 'B%';

-- 6. List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name
select *
from whole_dept_emp
where dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select *
from whole_dept_emp
where dept_name = 'Sales' 
or dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select count(*) from employees group by last_name;
 
select last_name, count(last_name) as "last_count"
from employees
group by employees.last_name
order by last_name desc;
