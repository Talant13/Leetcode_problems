select customer_id,
       count(*) as total_orders,
       round(
         sum(case when to_char(order_timestamp,'HH24:MI:SS') between '11:00:00' and '14:00:00'
                    or to_char(order_timestamp,'HH24:MI:SS') between '18:00:00' and '21:00:00'
                  then 1 else 0 end) / count(*) * 100
       ) as peak_hour_percentage,
       round(avg(order_rating), 2) as average_rating
  from restaurant_orders
 group by customer_id
having count(*) >= 3
   and round(
         sum(case when to_char(order_timestamp,'HH24:MI:SS') between '11:00:00' and '14:00:00'
                    or to_char(order_timestamp,'HH24:MI:SS') between '18:00:00' and '21:00:00'
                  then 1 else 0 end) / count(*) * 100
       ) >= 60
   and avg(order_rating) >= 4.0
   and count(order_rating) / count(*) >= 0.5
 order by average_rating desc, customer_id desc;
