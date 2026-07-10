WITH last3 AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn,
        COUNT(*)     OVER (PARTITION BY employee_id)                           AS total_reviews
    FROM performance_reviews
),
filtered AS (
    SELECT employee_id, rating, rn
    FROM last3
    WHERE rn <= 3 AND total_reviews >= 3
),
pivoted AS (
    SELECT
        employee_id,
        MAX(CASE WHEN rn = 1 THEN rating END) AS latest,
        MAX(CASE WHEN rn = 2 THEN rating END) AS middle,
        MAX(CASE WHEN rn = 3 THEN rating END) AS earliest
    FROM filtered
    GROUP BY employee_id
)
SELECT
    p.employee_id,
    e.name,
    p.latest - p.earliest AS improvement_score
FROM pivoted p
JOIN employees e ON p.employee_id = e.employee_id
WHERE p.latest > p.middle AND p.middle > p.earliest
ORDER BY improvement_score DESC, e.name ASC
