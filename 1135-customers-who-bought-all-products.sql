with custom as(
    select distinct c.customer_id,
           c.product_key   
  from Customer c
), 
final as
(
    Select cc.customer_id,
           count(cc.customer_id) cntc
      from custom cc
    group by cc.customer_id
)
Select f.customer_id
  from final f
  where f.cntc =   (select count(p.product_key) cnt
                      from Product p)