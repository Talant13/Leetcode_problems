/* Write your PL/SQL query statement below */

select t.player_id,
       to_char(t.event_date, 'yyyy-mm-dd') as first_login
  from(
        select t.player_id,
               t.event_date,
               dense_rank()over(partition by player_id order by event_date asc) as rnk
          from activity t
      )t
    where t.rnk = 1