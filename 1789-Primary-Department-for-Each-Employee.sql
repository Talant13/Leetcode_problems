
with cte as(
        select e.employee_id,
            E.department_id,
            e.primary_flag,
            row_number()over(partition by e.employee_id order by e.primary_flag desc) as rn
        from Employee e
)select c.employee_id,
        c.department_id
   from cte c
  where rn = 1
