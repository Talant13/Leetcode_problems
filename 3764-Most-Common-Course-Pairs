
with q_s as (
select c.user_id,
       count(c.course_id) as cnt_course,
       avg(c.course_rating) as avg_r
  from course_completions c
 group by c.user_id
 having count(c.course_id) >= 5
    and avg(c.course_rating) >= 4
),
tab as (
select c.user_id,
        c.course_name,
        row_number()over(partition by c.user_id order by c.completion_date asc, c.course_id asc) as rnk,
        row_number()over(partition by c.user_id order by c.completion_date asc, c.course_id asc) + 1 as rnk_n
   from course_completions c
   join q_s q on q.user_id =c.user_id
)select --t.user_id,
        t.course_name as first_course,
        t2.course_name as second_course,
        count(*) as transition_count
   from tab t
   join tab t2 on t2.user_id = t.user_id
              and t2.rnk = t.rnk_n
 group by t.course_name,
          t2.course_name
order by count(*) desc,
         lower(t.course_name) asc,
         lower(t2.course_name) asc
