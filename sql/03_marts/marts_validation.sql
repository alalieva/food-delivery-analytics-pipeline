-- 01. Grain check:

-- marts_orders 
-- Expected: total_rows = distinct_orders
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM marts.marts_orders;

-- mart_users 
-- Expected: total_rows = distinct_users
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT user_id) AS distinct_users
FROM marts.mart_users;

-- mart_restaurants 
-- Expected: total_rows = distinct_restaurants
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT restaurant_id) AS distinct_restaurants
FROM marts.mart_restaurants;

-- mart_daily_metrics 
-- Expected: total_rows = distinct_order_dates
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_date) AS distinct_order_dates
FROM marts.mart_daily_metrics;
------------------------------------------------------------


-- 02. Revenue: orders vs daily mart
-- Expected: values should match

SELECT
    ROUND(SUM(total_amount), 2) AS orders_gross_order_value
FROM marts.marts_orders
WHERE has_data_quality_issue = FALSE;

SELECT
    ROUND(SUM(gross_order_value), 2) AS daily_gross_order_value
FROM marts.mart_daily_metrics;
------------------------------------------------------------


-- 03. Commission: orders vs restaurant mart
-- Expected: values should match

SELECT
    ROUND(SUM(restaurant_commission_amount), 2) AS orders_total_commission
FROM marts.marts_orders
WHERE has_data_quality_issue = FALSE;

SELECT
    ROUND(SUM(total_commission_revenue), 2) AS restaurant_total_commission
FROM marts.mart_restaurants;
------------------------------------------------------------


-- 04. Payout: orders vs restaurant mart
-- Expected: values should match

SELECT
    ROUND(SUM(restaurant_payout_amount), 2) AS orders_total_payout
FROM marts.marts_orders
WHERE has_data_quality_issue = FALSE;

SELECT
    ROUND(SUM(total_payout_amount), 2) AS restaurant_total_payout
FROM marts.mart_restaurants;
------------------------------------------------------------


-- 05. User order count 
-- Expected: values should match

SELECT
    COUNT(order_id) AS orders_total_orders
FROM marts.marts_orders
WHERE has_data_quality_issue = FALSE;

SELECT
    SUM(total_orders) AS users_total_orders
FROM marts.mart_users;

SELECT
    SUM(total_orders) AS restaurants_total_orders
FROM marts.mart_restaurants;

SELECT
    SUM(total_orders) AS daily_total_orders
FROM marts.mart_daily_metrics;
------------------------------------------------------------


-- 06. Check excluded invalid records
-- Expected: invalid_orders > 0 if quality issues exist

SELECT
    COUNT(*) AS invalid_orders
FROM marts.marts_orders
WHERE has_data_quality_issue = TRUE;
------------------------------------------------------------


-- 07. Check for NULL key fields in marts_orders
-- Expected: all values should be 0

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE user_id IS NULL) AS null_user_id,
    COUNT(*) FILTER (WHERE restaurant_id IS NULL) AS null_restaurant_id
FROM marts.marts_orders;
------------------------------------------------------------


-- 08. Check for negative financial values
-- Expected: all values should be 0

SELECT
    COUNT(*) FILTER (WHERE food_amount < 0) AS negative_food_amount,
    COUNT(*) FILTER (WHERE delivery_fee < 0) AS negative_delivery_fee,
    COUNT(*) FILTER (WHERE total_amount < 0) AS negative_total_amount,
    COUNT(*) FILTER (WHERE restaurant_commission_amount < 0) AS negative_commission_amount,
    COUNT(*) FILTER (WHERE restaurant_payout_amount < 0) AS negative_payout_amount
FROM marts.marts_orders;
------------------------------------------------------------


-- 09. Check user segments
-- Expected: only one_time, regular, power_user

SELECT
    user_segment,
    COUNT(*) AS users_count
FROM marts.mart_users
GROUP BY user_segment
ORDER BY users_count DESC;