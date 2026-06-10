select Round(sum(i.tiv_2016),2) as tiv_2016
  from Insurance i
where i.tiv_2015 in 
(
    select i.tiv_2015
      from Insurance i
      group by i.tiv_2015
      having count(i.tiv_2015) > 1
)
and (i.lat, i.lon) in
(
    select i.lat,
           i.lon 
      from Insurance i
      group by i.lat,
               i.lon
      Having count(*) = 1
);
