with cte as(
SELECT t.id,
       t.p_id as tpid,
       p.p_id
FROM Tree t
LEFT JOIN Tree p
  ON t.id = p.p_id
)select distinct c.id,
        case when tpid is null then 'Root'
             when tpid is not null and p_id is not null then 'Inner'
             when tpid is not null and p_id is null then 'Leaf'
            end as "type"
   from cte c
   order by c.id
