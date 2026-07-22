
with exp as(
select i.store_id,
       i.product_name,
       i.quantity,
       i.price,
       dense_rank()over(partition by i.store_id order by i.price desc) as rnk
  from inventory i
), cheap as(
select i.store_id,
       i.product_name,
       i.quantity,
       i.price,
       dense_rank()over(partition by i.store_id order by i.price asc) as rnk
  from inventory i
), trsh as(
select i.store_id,
       count(i.product_name) as cnt_p
  from inventory i
 group by i.store_id
 having count(i.product_name) >=3
)
select e.store_id,
       s.store_name,
       s.location,
       e.product_name as most_exp_product,
       c.product_name as cheapest_product,
       round(c.quantity / e.quantity,2) as imbalance_ratio
  from exp e
   join cheap c on c.store_id = e.store_id
   join trsh t on e.store_id = t.store_id
   join stores s on s.store_id = e.store_id
where e.rnk = 1
  and c.rnk = 1
  and e.quantity < c.quantity
order by round(c.quantity / e.quantity,2) desc,
         s.store_name asc
