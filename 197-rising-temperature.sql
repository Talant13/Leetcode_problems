/* Write your PL/SQL query statement below */
select w2.id Id
from weather w1, weather w2
where   w2.recordDate - w1.recordDate = 1 and
        w2.temperature > w1.temperature;