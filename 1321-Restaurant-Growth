WITH DailyTotals AS (
    SELECT 
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
), cte as(
SELECT 
    visited_on,
    ROUND(
        sum(daily_amount) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_sum_7day,
    ROUND(
        AVG(daily_amount) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_7day,
    row_number()over(order by visited_on) as row_num
FROM DailyTotals
)Select to_char(visited_on, 'yyyy-mm-dd') as visited_on,
        moving_sum_7day as amount,
        moving_avg_7day as average_amount
    from cte
where row_num >=7
