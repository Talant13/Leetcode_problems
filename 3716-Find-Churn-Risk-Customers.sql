with ranked as (
  select e.user_id, 
         e.event_type, 
         e.plan_name, 
         e.monthly_amount, 
         e.event_date,
         row_number() over (partition by e.user_id
                            order by e.event_date desc, e.event_id desc) as rnk
  from subscription_events e
),
agg as (
  select user_id,
         max(monthly_amount) as max_amount,
         max(event_date) - min(event_date) as subs_days,
         max(case when event_type = 'downgrade' then 1 else 0 end) as has_downgrade
  from subscription_events
  group by user_id
)
select r.user_id,
       r.plan_name as current_plan,
       r.monthly_amount as current_monthly_amount,
       a.max_amount as max_historical_amount,
       a.subs_days as days_as_subscriber
from ranked r
join agg a on a.user_id = r.user_id
where r.rnk = 1
  and r.event_type <> 'cancel'          
  and a.has_downgrade = 1               
  and a.subs_days >= 60                 
  and r.monthly_amount < 0.5 * a.max_amount   
order by a.subs_days desc, r.user_id asc;
