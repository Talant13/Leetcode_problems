/* Write your PL/SQL query statement below */

with cte as (select q.query_name,
       round(sum((q.rating/position)) / count(q.query_name),2) as quality,
       count(case when q.rating < 3 then 1 else null end) as tmp,
       count(q.query_name) cnt
  from Queries q
group by q.query_name
)select query_name,
        quality,
        case when tmp is not null then round(tmp/cnt*100,2)
          else 0 end as poor_query_percentage
    from cte
        
