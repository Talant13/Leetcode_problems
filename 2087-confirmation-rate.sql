


select s.user_id,
       case when c2.cnt2 <> 0 then Round(c2.cnt2 / c1.cnt, 2) else 0 end as confirmation_rate
  from signups s
left join (Select c.user_id,
                  count(c.action) as cnt
             from confirmations c
            group by c.user_id) c1 on c1.user_id = s.user_id
left join (Select c.user_id,
                  count(c.action) as cnt2
             from confirmations c
            where c.action = 'confirmed'
            group by c.user_id) c2 on c2.user_id = s.user_id
