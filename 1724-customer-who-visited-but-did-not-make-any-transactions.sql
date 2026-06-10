/* Write your PL/SQL query statement below */

select t.customer_id,
       count(customer_id) as count_no_trans
  from(
select v.customer_id,
       t.transaction_id
  from visits v
 left join transactions t on t.visit_id = v.visit_id
  ) t where t.transaction_id is null
  group by t.customer_id
