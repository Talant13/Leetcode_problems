
with cte as (select e.employee_id,
       e.name,
       m.employee_id as m_id,
       m.name as manager,
       e.age
  from Employees e
  left join Employees m on m.employee_id = e.reports_to
)Select c.m_id as employee_id,
        c.manager as "name",
        count(c.manager) as reports_count,
        round(avg(c.age)) as average_age
   from cte c
   where c.manager is not null
group by c.m_id,
         c.manager
order by c.m_id
