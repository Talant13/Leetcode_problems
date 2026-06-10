with w1 as (
    select rank() over (partition by DepartmentId order by Salary desc) rank, 
    DepartmentId, 
    Name, 
    Salary
from Employee)

select d.Name as "Department", 
        w1.NAME as "Employee", 
        w1.SALARY as "Salary"
from w1 
    join Department d 
    on d.Id = w1.DEPARTMENTID and RANK = 1