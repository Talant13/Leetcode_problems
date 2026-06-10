

with tab1 as(
select requester_id,
       count(requester_id) as cnt
  from RequestAccepted
  group by requester_id

union all 

select accepter_id,
       count(accepter_id) as cnt
  from RequestAccepted
  group by accepter_id
), tab2 as(
    Select 
          requester_id as id,
          sum(cnt) summ
   from tab1
    group by requester_id
    order by sum(cnt) desc
)
select id,
       summ as num
  from tab2
  where rownum = 1
