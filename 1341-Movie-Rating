
with cte as(
    select m.title,
           u.name,
           mr.rating,
           mr.created_at
      from MovieRating mr
      left join Movies m on m.movie_id = mr.movie_id
      left join Users u on u.user_id = mr.user_id
), user_cte as (
select count(c.name) as cnt_name,
       c.name,
       row_number() over(order by count(c.name) desc, c.name asc) as rn
    from cte c
   group by c.name
), final_cte as (
    select avg(c.rating) as avg_r,
        c.title,
        row_number() over(order by avg(c.rating) desc, c.title asc) as rn
   from cte c
  where c.created_at >= to_date('2020-02-01', 'yyyy-mm-dd')
    and c.created_at <  to_date('2020-03-01', 'yyyy-mm-dd')
    group by c.title
)select uc.name as results
   from user_cte uc
where uc.rn = 1
union all
select fc.title
   from final_cte fc
   where fc.rn = 1
