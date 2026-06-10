/* Write your PL/SQL query statement below */

with fact as(
select u.user_id,
       to_char(u.join_date,'yyyy-mm-dd') as join_date,
       case when o.order_date >= to_date('01-01-2019', 'mm-dd-yyyy')
             and o.order_date < to_date('01-01-2020', 'mm-dd-yyyy')
             then 1
            else 0 end as cnt
  from Users u
 left join Orders o on o.buyer_id = u.user_id
)
select f.user_id as buyer_id,
       f.join_date,
       sum(f.cnt) as orders_in_2019 
  from fact f
  group by f.user_id,
           f.join_date
order by f.user_id asc