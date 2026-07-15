
with cte as (
    select e.employee_id,
           e.name,
           e.manager_id,
           e.salary
      from Employees e
    where e.manager_id is not null
      and e.salary < 30000
)
select c.employee_id
  from cte c
 left join Employees m on m.employee_id = c.manager_id
 where m.employee_id is null
 order by c.employee_id
