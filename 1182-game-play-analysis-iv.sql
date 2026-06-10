/* Write your PL/SQL query statement below */

   select round(sum(case when (select min(a1.event_date) 
                                 from activity a1 
                                where a1.player_id = a.player_id) + 1 = a.event_date 
                            then 1 else 0 end)/count(distinct a.player_id),2) as "fraction" 
  from activity a