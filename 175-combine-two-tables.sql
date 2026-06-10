/* Write your PL/SQL query statement below */

SELECT person.FirstName,
       person.LastName,
       address.City,
       address.State
FROM Person person  
left join Address address on person.PersonId = address.PersonId; 