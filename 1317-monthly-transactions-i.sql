/* Write your PL/SQL query statement below */


select TO_CHAR(s.trans_date, 'yyyy-mm') as month,
       s.country,
       count(s.id) as trans_count,
       nvl(t.trans_count,0) as approved_count,
       sum(s.amount) as trans_total_amount,
       nvl(t.trans_total_amount,0) as approved_total_amount
  from Transactions s
  left join (select TO_CHAR( s.trans_date, 'yyyy-mm') as months,
                     nvl(s.country, 'null') as country,
                     count(s.id) as trans_count,
                     sum(s.amount) as trans_total_amount
                from transactions s
                where s.state = 'approved'
                group by TO_CHAR( trans_date, 'yyyy-mm'),
                         country) t on t.months = TO_CHAR(s.trans_date, 'yyyy-mm')
                                   and t.country = nvl(s.country, 'null')
  group by TO_CHAR(s.trans_date, 'yyyy-mm'),
           s.country,
           nvl(t.trans_count,0),
           nvl(t.trans_total_amount,0)