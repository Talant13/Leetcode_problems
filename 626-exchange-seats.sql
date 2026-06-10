/* Write your PL/SQL query statement below */

select case 
          when mod(s.id,2) = 1 and s.id = (select max(t.id) from Seat t) then s.id
          when mod(s.id,2) = 1 then s.id + 1
          else s.id - 1 end as id,
        s.student
  from Seat s
  order by id asc