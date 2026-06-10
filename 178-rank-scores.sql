/* Write your PL/SQL query statement below */

select score,
dense_RANK() OVER(ORDER BY score DESC) rank 
from scores;