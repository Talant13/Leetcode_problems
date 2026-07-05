
with cte as (
    select nvl(e.employee_id, s.employee_id) as employee_id,
        s.salary,
        e.name
    from Employees e
    full join Salaries s on s.employee_id = e.employee_id
)Select c.employee_id
   from cte c
  where c.salary is null
     or c.name is null
  order by c.employee_id
