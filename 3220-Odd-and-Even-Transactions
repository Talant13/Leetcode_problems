select to_char(t.transaction_date,'yyyy-mm-dd') as transaction_date,
       sum(case when mod(t.amount,2) != 0 then amount else 0 end) as odd_sum,
       sum(case when mod(t.amount,2) = 0 then amount else 0 end) as even_sum
  from transactions t
 group by to_char(t.transaction_date,'yyyy-mm-dd')
 order by to_char(t.transaction_date,'yyyy-mm-dd') asc
