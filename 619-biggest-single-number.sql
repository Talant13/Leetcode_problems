/* Write your PL/SQL query statement below */
with temp as(
    select s.num,
           count(s.num) as cnt
      from MyNumbers s
    group by s.num
)
select max(t.num) as num
  from temp t
where t.cnt = 1