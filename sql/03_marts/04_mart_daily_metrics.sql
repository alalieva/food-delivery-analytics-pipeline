DROP TABLE IF EXISTS marts.mart_daily_metrics;

CREATE TABLE marts.mart_daily_metrics AS
SELECT
    order_date,
    order_year,
    order_month,

    COUNT(order_id) AS total_orders,

    COUNT(order_id) FILTER (WHERE is_delivered_order = TRUE) AS delivered_orders,
    COUNT(order_id) FILTER (WHERE is_cancelled_order = TRUE) AS cancelled_orders,
    COUNT(order_id) FILTER (WHERE is_refunded_payment = TRUE) AS refunded_orders,

    COUNT(DISTINCT user_id) AS active_users,
    COUNT(DISTINCT restaurant_id) AS active_restaurants,

    ROUND(SUM(food_amount), 2) AS total_food_sales,
    ROUND(SUM(delivery_fee), 2) AS total_delivery_revenue,
    ROUND(SUM(total_amount), 2) AS gross_order_value,
    ROUND(SUM(restaurant_commission_amount), 2) AS total_commission_revenue,
    ROUND(SUM(restaurant_payout_amount), 2) AS total_payout_amount,

    ROUND(AVG(food_amount), 2) AS avg_food_basket_value,
    ROUND(AVG(total_amount), 2) AS avg_order_value,

    ROUND(AVG(actual_delivery_minutes), 1) AS avg_delivery_minutes,

    COUNT(order_id) FILTER ( WHERE is_late_delivery = TRUE) AS late_delivery_count

FROM marts.marts_orders
WHERE has_data_quality_issue = FALSE
GROUP BY
    order_date,
    order_year,
    order_month
ORDER BY
    order_date;