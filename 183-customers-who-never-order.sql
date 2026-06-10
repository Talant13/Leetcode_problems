/* Write your PL/SQL query statement below */

select cust.name Customers
from Customers cust
left join Orders ord on cust.Id = ord.CustomerId;
where ord.CustomerId is null;