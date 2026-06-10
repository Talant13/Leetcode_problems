/* Write your PL/SQL query statement below */


select s.name
  from SalesPerson s

minus

select s.name
  from SalesPerson s
left join Orders o on o.sales_id = s.sales_id
left join Company c on c.com_id = o.com_id
where c.name = 'RED'