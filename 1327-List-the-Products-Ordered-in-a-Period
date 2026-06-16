/* Write your PL/SQL query statement below */

select p.product_name,
       sum(o.unit) as unit
  from Orders o
left join Products p on p.product_id = o.product_id
where o.order_date >= to_date('2020-02-01', 'yyyy-mm-dd')
  and o.order_date <  to_date('2020-03-01', 'yyyy-mm-dd')
group by p.product_name
having sum(o.unit) >= 100
