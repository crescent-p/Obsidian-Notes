suppose there is a table employee with emp_id, emp_name, dept_name, salary 

You want to find the max salary in all whole Institure.

`SELECT MAX(salary) FROM employee`

Now you want to find the max salary with employee details in each dept

`SELECT *, MAX(salary) over(PARTITION BY dept_name) as max_salary from employee`

`SELECT *, row_number()/rank()/dense_rank() over (PARTITION BY dept_name order by emp_id) as rn from employee`

rank -> if equal shows same number, then skips the number of equal rows.
dense_rank -> if equal shows same number , but doesn't skip the values.