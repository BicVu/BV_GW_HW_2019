-- START WITH BLANK SLATE
DROP TABLE departments CASCADE;
DROP TABLE dept_emp CASCADE;
DROP TABLE dept_manager CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE salaries CASCADE;
DROP TABLE titles CASCADE;


-- Create tables
drop table if exists departments;
create table departments(
	dept_no varchar not null,
	dept_name varchar not null
);
select * from departments limit 20;

drop table if exists dept_emp;
create table dept_emp(
	emp_no int not null,
	dept_no varchar not null,
	from_date date,
	to_date date
);
select * from dept_emp limit 20;

drop table if exists dept_manager;
create table dept_manager(
	dept_no varchar not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null
);
select * from dept_manager limit 20;

drop table if exists employees;
create table employees(
	emp_no int not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	gender varchar not null,
	hire_date date not null
);
select * from employees limit 20;

drop table if exists salaries;
create table salaries(
	emp_no int not null,
	salary int	not null,
	from_date date not null,
	to_date date not null
);
select * from salaries limit 20;

drop table if exists titles;
create table titles(
	emp_no int not null,
	title varchar not null,
	from_date date not null,
	to_date date not null
);
select * from titles limit 20;

ALTER TABLE employees ADD CONSTRAINT pk_employees_emp_no PRIMARY KEY(emp_no);
ALTER TABLE departments ADD CONSTRAINT pk_departments_dept_no PRIMARY KEY(dept_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no);
ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no) REFERENCES departments(dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no);
ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no) REFERENCES departments(dept_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no);

