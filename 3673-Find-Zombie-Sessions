 Select e.session_id,
        e.user_id,
        (max(e.event_timestamp) - min(e.event_timestamp)) * 24 * 60 as session_duration_minutes,
        sum(case when e.event_type = 'scroll' then 1 else 0 end) as scroll_count
   from app_events e
   group by e.session_id,
            e.user_id
  having round(sum(case when e.event_type = 'click' then 1 else 0 end)/sum(case when e.event_type = 'scroll' then 1 else 0 end),2) < 0.20
     and sum(case when e.event_type = 'purchase' then 1 else 0 end) = 0
     and sum(case when e.event_type = 'scroll' then 1 else 0 end) >= 5
     and (max(e.event_timestamp) - min(e.event_timestamp)) * 24 * 60 > 30
order by sum(case when e.event_type = 'scroll' then 1 else 0 end) desc,
         e.session_id asc
