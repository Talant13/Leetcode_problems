select *
  from Patients p
 where p.conditions like '% DIAB1%'
    or p.conditions like 'DIAB1%'
