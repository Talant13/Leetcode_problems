-- /* Write your PL/SQL query statement below */


-- select a.Email
-- from Person a, Person b
-- where a.Email like b.Email;

select email
from person
group by email
having count(email) > 1;