-- 1. Orders outside expected project period
SELECT
    COUNT(*) AS orders_outside_expected_period
FROM raw.orders
WHERE order_datetime < '2024-01-01'
   OR order_datetime >= '2026-01-01';

---------------------------------------------

-- 2. Users signed up after their order date
SELECT
    COUNT(*) AS orders_before_user_signup
FROM raw.users u
LEFT JOIN raw.orders o 
    ON u.user_id = o.user_id
WHERE signup_date > order_datetime;

---------------------------------------------

-- 3. Subscription start date before signup date
SELECT 
    COUNT(*) AS subscription_before_user_signup
FROM raw.users
WHERE subscription_start_date IS NOT NULL
    AND subscription_start_date < signup_date;
-- 14 Subscription start date before signup date

-- Inspect subscription dates before signup date
SELECT
    user_id,
    signup_date,
    subscription_start_date,
    signup_date - subscription_start_date AS days_before_signup
FROM raw.users
WHERE subscription_start_date IS NOT NULL
  AND subscription_start_date < signup_date
ORDER BY days_before_signup DESC;

---------------------------------------------

-- 4. Pickup time before order time
SELECT 
    COUNT(*) AS pickup_befor_order_time
FROM raw.orders o
LEFT JOIN raw.deliveries d
    ON o.order_id = d.order_id
WHERE pickup_time < order_datetime;

---------------------------------------------

--- 5. Delivered time before pickup time
SELECT  
    COUNT(*) AS delivered_before_pickup
FROM raw.deliveries 
WHERE delivered_time < pickup_time;
-- 73 delivery records where delivered_time < pickup_time


-- Inspect delivered time before pickup time
SELECT
    delivery_id,
    order_id,
    pickup_time,
    delivered_time,
    ROUND(
        EXTRACT(EPOCH FROM (delivered_time - pickup_time)) / 60,
        2
    ) AS calculated_delivery_minutes,
    actual_delivery_minutes,
    delivery_status
FROM raw.deliveries
WHERE pickup_time IS NOT NULL
  AND delivered_time IS NOT NULL
  AND delivered_time < pickup_time
ORDER BY calculated_delivery_minutes;

---------------------------------------------

---- 6. Actual delivery minutes does not match timestamp difference
SELECT
    COUNT(*) AS mismatched_actual_delivery_minutes
FROM raw.deliveries
WHERE pickup_time IS NOT NULL
  AND delivered_time IS NOT NULL
  AND actual_delivery_minutes IS NOT NULL
  AND ABS(
      EXTRACT(EPOCH FROM (delivered_time - pickup_time)) / 60
      - actual_delivery_minutes
  ) > 1;
-- 218 delivery records have inconsistencies between calculated delivery duration and actual_delivery_minutes

-- Inspect mismatched delivery duration records
SELECT
    delivery_id,
    order_id,
    pickup_time,
    delivered_time,
    actual_delivery_minutes,
    ROUND(EXTRACT(EPOCH FROM (delivered_time - pickup_time)) / 60, 2) AS calculated_delivery_minutes
FROM raw.deliveries
WHERE pickup_time IS NOT NULL
  AND delivered_time IS NOT NULL
  AND actual_delivery_minutes IS NOT NULL
  AND ABS(
      EXTRACT(EPOCH FROM (delivered_time - pickup_time)) / 60
      - actual_delivery_minutes
  ) > 1
ORDER BY order_id;