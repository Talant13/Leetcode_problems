/* Write your PL/SQL query statement below */

select department,
       employee,
       salary
  from(
select d.name as department,
       e.name as employee,
       e.salary,
       dense_rank() over(partition by e.departmentid order by salary desc) as rnk
  from employee e
 inner join department d on d.id = e.departmentid
      ) t
      where t.rnk <= 3