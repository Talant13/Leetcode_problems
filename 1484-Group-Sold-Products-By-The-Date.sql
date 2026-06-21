with cte as(
    Select distinct a.sell_date,
           a.product
      from Activities a
)
select to_char(a.sell_date, 'yyyy-mm-dd') as sell_date,
       count(distinct a.product) as num_sold,
    listagg(a.product, ',') within group (order by a.product) as products
  from cte a
  group by to_char(a.sell_date, 'yyyy-mm-dd')
