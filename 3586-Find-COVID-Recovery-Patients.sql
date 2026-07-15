with first_pos as (
    select patient_id,
           min(test_date) as pos_date
    from covid_tests
    where result = 'Positive'
    group by patient_id
),
first_neg as (
    select c.patient_id,
           min(c.test_date) as neg_date
    from covid_tests c
    join first_pos fp
      on fp.patient_id = c.patient_id
     and c.test_date > fp.pos_date
    where c.result = 'Negative'
    group by c.patient_id
)
select p.patient_id,
       p.patient_name,
       p.age,
       (fn.neg_date - fp.pos_date) as recovery_time
from first_pos fp
join first_neg fn on fn.patient_id = fp.patient_id
join patients  p  on p.patient_id  = fp.patient_id
order by recovery_time asc,
         p.patient_name asc;
