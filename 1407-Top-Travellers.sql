/* Write your PL/SQL query statement below */

select u.name,
       sum(case when r.distance is null then 0 else r.distance end) as travelled_distance 
  from Rides r
right join users u on u.id = r.user_id
group by u.name,
         u.id
order by sum(case when r.distance is null then 0 else r.distance end) desc,
         u.name asc
