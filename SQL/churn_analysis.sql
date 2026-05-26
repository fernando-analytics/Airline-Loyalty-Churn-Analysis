-- =====================================================
-- AIRLINE LOYALTY CHURN ANALYSIS
-- =====================================================


-- =====================================================
-- 1. CUSTOMER CANCELLATION OVERVIEW
-- =====================================================

SELECT
    CASE
        WHEN cancellation_year IS NULL THEN 'Active'
        ELSE 'Cancelled'
    END AS customer_status,
    COUNT(*) AS customers
FROM customer_data
GROUP BY customer_status;


-- =====================================================
-- 2. CANCELLATION RATE
-- =====================================================

SELECT
    ROUND(
        100.0 *
        SUM(CASE WHEN cancellation_year IS NOT NULL THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS cancellation_rate
FROM customer_data;


-- =====================================================
-- 3. AVERAGE CLV BY CUSTOMER STATUS
-- =====================================================

SELECT
    CASE
        WHEN cancellation_year IS NULL THEN 'Active'
        ELSE 'Cancelled'
    END AS customer_status,
    AVG(clv) AS avg_clv
FROM customer_data
GROUP BY customer_status;


-- =====================================================
-- 4. LOYALTY CARD DISTRIBUTION
-- =====================================================

SELECT
    loyalty_card,
    COUNT(*) AS customers
FROM customer_data
GROUP BY loyalty_card
ORDER BY customers DESC;


-- =====================================================
-- 5. AVERAGE FLIGHT ACTIVITY
-- =====================================================

SELECT
    cancelled,
    AVG(total_flights) AS avg_flights,
    AVG(distance) AS avg_distance,
    AVG(points_accumulated) AS avg_points_accumulated,
    AVG(points_redeemed) AS avg_points_redeemed
FROM customer_data
GROUP BY cancelled;


-- =====================================================
-- 6. MEDIAN-LIKE VIEW OF POINT REDEMPTION
-- =====================================================

SELECT
    cancelled,
    AVG(points_redeemed) AS avg_points_redeemed
FROM customer_data
GROUP BY cancelled;


-- =====================================================
-- 7. SALARY COMPARISON
-- =====================================================

SELECT
    cancelled,
    AVG(salary) AS avg_salary
FROM customer_data
GROUP BY cancelled;


-- =====================================================
-- 8. EDUCATION VS CANCELLATION
-- =====================================================

SELECT
    education,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY education
ORDER BY cancellation_rate DESC;


-- =====================================================
-- 9. MARITAL STATUS VS CANCELLATION
-- =====================================================

SELECT
    marital_status,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY marital_status
ORDER BY cancellation_rate DESC;


-- =====================================================
-- 10. GENDER VS CANCELLATION
-- =====================================================

SELECT
    gender,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY gender
ORDER BY cancellation_rate DESC;


-- =====================================================
-- 11. PROVINCE VS CANCELLATION
-- =====================================================

SELECT
    province,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY province
ORDER BY cancellation_rate DESC;


-- =====================================================
-- 12. LOW ACTIVITY CUSTOMERS
-- =====================================================

SELECT
    CASE
        WHEN total_flights = 0 THEN 'No Flights'
        WHEN total_flights BETWEEN 1 AND 10 THEN '1-10'
        WHEN total_flights BETWEEN 11 AND 20 THEN '11-20'
        WHEN total_flights BETWEEN 21 AND 30 THEN '21-30'
        WHEN total_flights BETWEEN 31 AND 40 THEN '31-40'
        ELSE '40+'
    END AS flight_band,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY flight_band
ORDER BY cancellation_rate DESC;


-- =====================================================
-- 13. POINT REDEMPTION VS CANCELLATION
-- =====================================================

SELECT
    CASE
        WHEN points_redeemed > 0 THEN 'Redeemed Points'
        ELSE 'No Redemption'
    END AS redemption_group,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY redemption_group;


-- =====================================================
-- 14. ENGAGEMENT SEGMENT
-- =====================================================

SELECT
    CASE
        WHEN total_flights > 20
             AND points_redeemed > 0
        THEN 'Engaged'
        ELSE 'Less Engaged'
    END AS engagement_group,
    COUNT(*) AS customers,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY engagement_group;


-- =====================================================
-- 15. WHERE MOST CANCELLATIONS COME FROM
-- =====================================================

SELECT
    CASE
        WHEN total_flights > 20
             AND points_redeemed > 0
        THEN 'Engaged'
        ELSE 'Less Engaged'
    END AS engagement_group,
    SUM(cancelled) AS total_cancellations
FROM customer_data
GROUP BY engagement_group;


-- =====================================================
-- 16. TOP INSIGHT
-- =====================================================

SELECT
    CASE
        WHEN total_flights > 20
             AND points_redeemed > 0
        THEN 'Engaged'
        ELSE 'Less Engaged'
    END AS engagement_group,
    COUNT(*) AS customers,
    SUM(cancelled) AS cancellations,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM customer_data
GROUP BY engagement_group
ORDER BY cancellation_rate DESC;