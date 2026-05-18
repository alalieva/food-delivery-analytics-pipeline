DROP TABLE IF EXISTS marts.mart_users;

CREATE TABLE marts.mart_users AS
SELECT 
    user_id,
    user_full_name,
    user_email,
    user_city,
    user_signup_date,
    user_is_subscriber,
    user_subscription_start_date,

    COUNT(order_id) as total_orders,

    COUNT(order_id) FILTER ( WHERE is_delivered_order = TRUE) AS delivered_orders,
    COUNT(order_id) FILTER ( WHERE is_cancelled_order = TRUE) AS cancelled_orders,
    COUNT(order_id) FILTER ( WHERE is_refunded_payment = TRUE) AS refunded_orders,

    ROUND(SUM(food_amount), 2) AS total_food_revenue,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,

    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,

    MAX(order_date) - MIN(order_date) AS customer_lifetime_days,

    ROUND(AVG(actual_delivery_minutes), 1)
        AS avg_delivery_minutes,

    COUNT(order_id) FILTER (WHERE is_late_delivery = TRUE) AS late_delivery_count,

    CASE
        WHEN COUNT(order_id) = 1 THEN 'one_time'
        WHEN COUNT(order_id) BETWEEN 2 AND 5 THEN 'regular'
        ELSE 'power_user'
    END as user_segment

    
FROM marts.marts_orders 
WHERE has_data_quality_issue = FALSE  -- Exclude invalid data for correct aggregation
GROUP BY 
    user_id,
    user_full_name,
    user_email,
    user_city,
    user_signup_date,
    user_is_subscriber,
    user_subscription_start_date;


