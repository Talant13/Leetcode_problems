with cte as(
select q.*,
       sum(weight)over(order by turn) as lim
  from Queue q
  order by q.turn desc
)select c.person_name
   from cte c
 where lim <=1000 and rownum = 1
