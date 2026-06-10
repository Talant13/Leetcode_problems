/* Write your PL/SQL query statement below */


select s.product_id as "product_id",
       p.product_name as "product_name"
  from sales s
 inner join product p on p.product_id = s.product_id
 where s.sale_date >= to_date('2019-01-01', 'yyyy-mm-dd')
   and s.sale_date <=  to_date('2019-03-31', 'yyyy-mm-dd')
  
 minus
 
  select s.product_id as "product_id",
       p.product_name as "product_name"
  from sales s
 inner join product p on p.product_id = s.product_id
 where s.sale_date < to_date('2019-01-01', 'yyyy-mm-dd')
   or  s.sale_date >  to_date('2019-03-31', 'yyyy-mm-dd')