/* Write your PL/SQL query statement below */

with cte as(
select s.student_id,
       s.student_name,
       subject_name
  from students s
  cross join Subjects
  order by s.student_name
)select c.student_id,
        c.student_name,
        c.subject_name,
        count(e.subject_name) as attended_exams
   from cte c
left join Examinations e on e.student_id = c.student_id
                        and e.subject_name = c.subject_name
group by c.student_id,
         c.student_name,
         c.subject_name
order by c.student_id
