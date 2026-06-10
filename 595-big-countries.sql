/* Write your PL/SQL query statement below */

select con.name,
       con.population,
       con.area
    from World con
where area > 3000000 or population > 25000000;