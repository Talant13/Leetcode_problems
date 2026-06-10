/* Write your PL/SQL query statement below */


select t.x,
       t.y,
       t.z,
       case when x+y>z and y+z>x and x+z>y then 'Yes'
       else 'No' end as triangle 
  from Triangle t