DROP TABLE IF EXISTS marts.mart_restaurants;

CREATE TABLE  marts.mart_restaurants AS
SELECT 
    restaurant_id,
    restaurant_name,
    restaurant_city,
    restaurant_tier,
    cuisine_type,
    restaurant_avg_rating,
    restaurant_commission_rate,

    COUNT(order_id) AS total_orders,

    COUNT(order_id) FILTER (WHERE is_delivered_order) AS delivered_orders,
    COUNT(order_id) FILTER ( WHERE is_cancelled_order = TRUE) AS cancelled_orders,
    COUNT(order_id) FILTER ( WHERE is_refunded_payment = TRUE) AS refunded_orders,
    
    ROUND(SUM(food_amount), 2) AS total_food_sales, -- Total value of food sold by the restaurant
    ROUND(SUM(total_amount), 2) AS gross_order_value, -- Full user-paid order value(food amount + delivery fee)
    ROUND(SUM(restaurant_commission_amount), 2) AS total_commission_revenue,
    ROUND(SUM(restaurant_payout_amount), 2) AS total_payout_amount, -- The amount paid out to restaurants after platform commission
    ROUND(AVG(food_amount), 2) AS avg_food_basket_value, -- Average cost of food without delivery
    ROUND(AVG(total_amount), 2) AS avg_order_value, -- Average user total check

    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,

    ROUND(AVG(actual_delivery_minutes), 1) AS avg_delivery_minutes,

    COUNT(order_id) FILTER (WHERE is_late_delivery = TRUE) AS late_delivery_count

FROM marts.marts_orders
WHERE has_data_quality_issue = FALSE
GROUP BY 
    restaurant_id,
    restaurant_name,
    restaurant_city,
    restaurant_tier,
    cuisine_type,
    restaurant_avg_rating,
    restaurant_commission_rate;
