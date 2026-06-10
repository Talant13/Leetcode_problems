/* Write your PL/SQL query statement below */



 select 
        round(sum(case when order_date = customer_pref_delivery_date then 1 else 0 end) * 100 / count(customer_id), 2) as immediate_percentage
  from(
select customer_id,
       order_date,
       customer_pref_delivery_date,
       dense_rank() OVER
         (PARTITION BY customer_id order by order_date) AS rnk
  from Delivery d
  )where rnk = 1