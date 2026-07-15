with f_half as(
select t.driver_id,
       avg(t.distance_km / t.fuel_consumed) as avg_fuel
  from trips t
where t.trip_date >= to_date('2023-01-01', 'yyyy-mm-dd')
  and t.trip_date <  to_date('2023-07-01', 'yyyy-mm-dd')
  group by t.driver_id
), s_half as(
select t.driver_id,
       avg(t.distance_km / t.fuel_consumed) as avg_fuel
  from trips t
where t.trip_date >= to_date('2023-07-01', 'yyyy-mm-dd')
  and t.trip_date <  to_date('2024-01-01', 'yyyy-mm-dd')
  group by t.driver_id
)
select f.driver_id,
       d.driver_name,
       Round(f.avg_fuel,2) as first_half_avg,
       Round(s.avg_fuel,2) as second_half_avg,
       Round((s.avg_fuel - f.avg_fuel),2) as efficiency_improvement
  from f_half f
  join s_half s on s.driver_id = f.driver_id
               and s.avg_fuel > f.avg_fuel
  join drivers d on d.driver_id = f.driver_id
--   group by f.driver_id,
--            d.driver_name
order by s.avg_fuel - f.avg_fuel desc,
         d.driver_name asc


