
with cte as (
select r.user_id,
       sum(case when r.reaction is not null then 1 end) as total
  from reactions r
 group by r.user_id
 having sum(case when r.reaction is not null then 1 end) >= 5
)

select r.user_id,
       r.reaction as dominant_reaction,
       round(sum(case when r.reaction is not null then 1 else 0 end) / c.total,2) as reaction_ratio 
  from reactions r
 join cte c on c.user_id = r.user_id
 group by r.user_id,
          r.reaction,
          c.total
having sum(case when r.reaction is not null then 1 else 0 end) / c.total >= 0.6
order by sum(case when r.reaction is not null then 1 else 0 end) / c.total desc,
         r.user_id asc
