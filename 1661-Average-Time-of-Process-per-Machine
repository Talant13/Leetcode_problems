
Select s.machine_id,
       round(avg(e.timestamp  - s.timestamp),3) as processing_time
  from Activity s
  join Activity e on e.machine_id = s.machine_id
                 and e.process_id = s.process_id
                 and e.activity_type  = 'end'
where s.activity_type  = 'start'
group by s.machine_id
