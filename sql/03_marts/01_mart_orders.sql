-- Order-level mart. One row per order.
DROP TABLE IF EXISTS marts.marts_orders;

CREATE TABLE marts.marts_orders AS
SELECT
    o.order_id,
    o.user_id,
    o.restaurant_id,
    p.payment_id,
    d.delivery_id,

    o.order_datetime,
    o.order_date,
    o.order_year,
    o.order_month,
    o.order_status,
    o.refund_reason,

    u.full_name AS user_full_name,
    u.email AS user_email,
    u.city AS user_city,
    u.signup_date AS user_signup_date,
    u.is_subscriber AS user_is_subscriber,
    u.subscription_start_date AS user_subscription_start_date,

    r.restaurant_name,
    r.cuisine_type,
    r.city AS restaurant_city,
    r.restaurant_tier,
    r.avg_rating AS restaurant_avg_rating,
    r.commission_rate AS restaurant_commission_rate,

    p.payment_method,
    p.payment_status,
    p.currency,
    p.food_amount,
    p.delivery_fee,
    p.total_amount,

    d.courier_id,
    d.distance_km,
    d.estimated_delivery_minutes,
    d.pickup_time,
    d.delivered_time,
    d.delivery_status,
    d.actual_delivery_minutes,

    -- Business metrics
    ROUND(p.food_amount * r.commission_rate, 2) AS restaurant_commission_amount,
    ROUND(p.food_amount - (p.food_amount * r.commission_rate), 2) AS restaurant_payout_amount,

    -- Flags
    CASE 
        WHEN o.order_status = 'delivered' THEN TRUE 
        ELSE FALSE 
    END AS is_delivered_order,

    CASE 
        WHEN o.order_status = 'cancelled' THEN TRUE 
        ELSE FALSE 
    END AS is_cancelled_order,

    CASE 
        WHEN p.payment_status = 'refunded' THEN TRUE 
        ELSE FALSE 
    END AS is_refunded_payment,

    CASE 
        WHEN d.actual_delivery_minutes > d.estimated_delivery_minutes THEN TRUE
        ELSE FALSE
    END AS is_late_delivery,

    
    -- Data quality flags
    u.has_subscription_before_signup,
    d.has_delivered_before_pickup,
    d.has_invalid_delivery_duration,
    d.has_unusual_delivery_duration,

    CASE
    WHEN u.has_subscription_before_signup = TRUE
        OR d.has_delivered_before_pickup = TRUE
        OR d.has_invalid_delivery_duration = TRUE
        OR d.has_unusual_delivery_duration = TRUE
    THEN TRUE
    ELSE FALSE
    END AS has_data_quality_issue

FROM staging.stg_orders o
LEFT JOIN staging.stg_users u
    ON o.user_id = u.user_id
LEFT JOIN staging.stg_restaurants r
    ON o.restaurant_id = r.restaurant_id
LEFT JOIN staging.stg_payments p
    ON o.order_id = p.order_id
LEFT JOIN staging.stg_deliveries d
    ON o.order_id = d.order_id;

-- Check 
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM marts.marts_orders;

