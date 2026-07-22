/* Write your PL/SQL query statement below */

with f as (
    select t.customer_id,
            t.transaction_date,
            t.amount,
            t.transaction_type,
            dense_rank()over(partition by t.customer_id order by t.transaction_date asc) as rnk_f
    from customer_transactions t
), l as (
    select t.customer_id,
        t.transaction_date,
        t.amount,
        t.transaction_type,
        dense_rank()over(partition by t.customer_id order by t.transaction_date desc) as rnk_l 
    from customer_transactions t
), rate as(
    select t.customer_id,
           round(sum(case when t.transaction_type = 'refund' then 1 else 0 end)/count(t.transaction_id),2) as r_rate
from customer_transactions t
group by t.customer_id
having count(t.transaction_id) >= 3
)
select distinct f.customer_id
  from f
  join l on l.customer_id = f.customer_id
  join rate r on r.customer_id = f.customer_id
  where l.rnk_l = 1
    and f.rnk_f = 1
    and l.transaction_date - f.transaction_date >=30
    and r.r_rate < 0.2
order by f.customer_id asc
