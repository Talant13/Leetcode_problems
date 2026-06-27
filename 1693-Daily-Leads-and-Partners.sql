
select to_char(d.date_id, 'yyyy-mm-dd') as date_id ,
       d.make_name,
       count(distinct lead_id) as unique_leads,
       count(distinct partner_id) as unique_partners
  from DailySales d
group by d.date_id,
         d.make_name
