select distinct num as ConsecutiveNums
  from(
select l.num,
       LEAD(l.num) OVER( order by l.id) as lead,
       LAG(l.num) OVER (order by l.id) as lag
  from Logs l
  )
  where num = Lead 
    and lead = lag