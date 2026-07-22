WITH tab1 AS (
    SELECT m.employee_id,
           e.employee_name,
           e.department,
           to_char(to_date(m.meeting_date, 'yyyy-mm-dd'), 'IYYY-IW') AS week_num,
           SUM(m.duration_hours) AS dur_hour
      FROM meetings m
      JOIN employees e ON e.employee_id = m.employee_id
     GROUP BY m.employee_id,
              e.employee_name,
              e.department,
              to_char(to_date(m.meeting_date, 'yyyy-mm-dd'), 'IYYY-IW')
)
SELECT t.employee_id,
       t.employee_name,
       t.department,
       COUNT(*) AS meeting_heavy_weeks
  FROM tab1 t
 WHERE t.dur_hour > 20
 GROUP BY t.employee_id,
          t.employee_name,
          t.department
HAVING COUNT(*) > 1
 ORDER BY COUNT(*) DESC,
          t.employee_name ASC;
