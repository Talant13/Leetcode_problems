CREATE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
result NUMBER;
BEGIN
    /* Write your PL/SQL query statement below */
  select distinct Salary into result
    from 
        (select dense_rank() over (order by salary desc) as Ranks, ID, Salary
         from Employee) a
         where a.Ranks = N;
    RETURN result;
END;

