/* Write your PL/SQL query statement below */


with cte as(
    select case when a.income < 20000 then 'Low Salary'
                when a.income >= 20000 and a.income <= 50000 then 'Average Salary'
                when a.income > 50000 then 'High Salary' end as temp,
            a.income
      from Accounts a
), salaries as(
    select 'Low Salary' as type_salary,
            0 as balance
      from dual
    union all 
    select 'Average Salary' as type_salary,
            0 as balance
      from dual
    union all
    select 'High Salary' as type_salary,
            0 as balance
      from dual
)
select  s.type_salary as category,
        count(c.income) as accounts_count 
   from cte c
   right join salaries s on s.type_salary = c.temp
   group by s.type_salary
