SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE user_id IS NULL) AS null_user_id,
    COUNT(*) FILTER (WHERE full_name IS NULL) AS null_full_name,
    COUNT(*) FILTER (WHERE email IS NULL) AS null_email,
    COUNT(*) FILTER (WHERE city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE signup_date IS NULL) AS null_signup_date,
    COUNT(*) FILTER (WHERE is_subscriber IS NULL) AS null_is_subscriber,
    COUNT(*) FILTER (WHERE subscription_start_date IS NULL) AS null_subscription_start_date  -- Expected NULLs for users  without subscription
FROM raw.users;


SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE user_id IS NULL) AS null_user_id,
    COUNT(*) FILTER (WHERE restaurant_id IS NULL) AS null_restaurant_id,
    COUNT(*) FILTER (WHERE order_datetime IS NULL) AS null_order_datetime,
    COUNT(*) FILTER (WHERE order_status IS NULL) AS null_order_status,
    COUNT(*) FILTER (WHERE refund_reason IS NULL) AS null_refund_reason -- Expected NULLs for non-refunded orders
FROM raw.orders;


SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE delivery_id IS NULL) AS null_delivery_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE courier_id IS NULL) AS null_courier_id,
    COUNT(*) FILTER (WHERE distance_km IS NULL) AS null_distance_km,
    COUNT(*) FILTER (WHERE estimated_delivery_minutes IS NULL) AS null_estimated_delivery_minutes, 
    COUNT(*) FILTER (WHERE pickup_time IS NULL) AS null_pickup_time, -- Expected NULLs 
    COUNT(*) FILTER (WHERE delivered_time IS NULL) AS null_delivered_time, -- Expected NULLs 
    COUNT(*) FILTER (WHERE delivery_status IS NULL) AS null_delivery_status,
    COUNT(*) FILTER (WHERE actual_delivery_minutes IS NULL) AS null_actual_delivery_minutes -- Expected NULLs 
FROM raw.deliveries;


SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE payment_id IS NULL) AS null_payment_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE payment_method IS NULL) AS null_payment_method,
    COUNT(*) FILTER (WHERE payment_status IS NULL) AS null_payment_status,
    COUNT(*) FILTER (WHERE currency IS NULL) AS null_currency, 
    COUNT(*) FILTER (WHERE food_amount IS NULL) AS null_food_amount, 
    COUNT(*) FILTER (WHERE delivery_fee IS NULL) AS null_delivery_fee, 
    COUNT(*) FILTER (WHERE total_amount IS NULL) AS null_total_amount
FROM raw.payments; 


SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE restaurant_id IS NULL) AS null_restaurant_id,
    COUNT(*) FILTER (WHERE restaurant_name IS NULL) AS null_restaurant_name,
    COUNT(*) FILTER (WHERE cuisine_type IS NULL) AS null_cuisine_type,
    COUNT(*) FILTER (WHERE city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE avg_rating IS NULL) AS null_avg_rating, 
    COUNT(*) FILTER (WHERE restaurant_tier IS NULL) AS null_restaurant_tier, 
    COUNT(*) FILTER (WHERE commission_rate IS NULL) AS null_commission_rate
FROM raw.restaurants; 