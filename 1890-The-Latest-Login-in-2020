with cte as(
    select l.user_id,
        l.time_stamp,
        dense_rank()over(partition by l.user_id order by l.time_stamp desc) as rnk
    from Logins l
    where l.time_stamp >= to_date('2020-01-01', 'yyyy-mm-dd')
    and l.time_stamp <  to_date('2021-01-01', 'yyyy-mm-dd') 
)
Select c.user_id,
       c.time_stamp as last_stamp
  from cte c
 where rnk = 1
