/* Write your PL/SQL query statement below */

with cte as(
    select s.stock_name,
        sum(case when s.operation = 'Buy' then s.price end) as buy,
        sum(case when s.operation = 'Sell' then s.price end) as sell
    from Stocks s
    group by s.stock_name
)select c.stock_name,
        c.sell - c.buy as capital_gain_loss 
   from cte c
