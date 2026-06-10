/* Write your PL/SQL query statement below */


with fact as(
    select sale_id,
           product_id,
           year,
           quantity,
           price,
           dense_rank()over (partition by product_id order by year) as rnk
      from Sales
)
select f.product_id,
       year as first_year,
       f.quantity,
       f.price
  from fact f
where rnk = 1