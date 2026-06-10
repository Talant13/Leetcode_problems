/* Write your PL/SQL query statement below */
with fact as(
    select a.actor_id,
           a.director_id,
           dense_rank()over(partition by a.actor_id, a.director_id order by a.timestamp) as rnk
      from ActorDirector a
)
select actor_id,
       director_id
  from fact
where rnk = 3