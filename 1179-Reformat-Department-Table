
select d.id,
       sum(case when d.month = 'Jan' then revenue end) as Jan_Revenue,
       sum(case when d.month = 'Feb' then revenue end) as Feb_Revenue,
       sum(case when d.month = 'Mar' then revenue end) as Mar_Revenue,
       sum(case when d.month = 'Apr' then revenue end) as Apr_Revenue,
       sum(case when d.month = 'May' then revenue end) as May_Revenue,
       sum(case when d.month = 'Jun' then revenue end) as Jun_Revenue,
       sum(case when d.month = 'Jul' then revenue end) as Jul_Revenue,
       sum(case when d.month = 'Aug' then revenue end) as Aug_Revenue,
       sum(case when d.month = 'Sep' then revenue end) as Sep_Revenue,
       sum(case when d.month = 'Oct' then revenue end) as Oct_Revenue,
       sum(case when d.month = 'Nov' then revenue end) as Nov_Revenue,
       sum(case when d.month = 'Dec' then revenue end) as Dec_Revenue
  from Department d
  group by d.id
