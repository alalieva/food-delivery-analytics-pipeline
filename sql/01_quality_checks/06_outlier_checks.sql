-- Outlier checks for unusually high / low values

-- 1. Negative or zero payment amounts
SELECT
    COUNT(*) AS invalid_payment_amounts
FROM raw.payments
WHERE food_amount <= 0
   OR delivery_fee < 0
   OR total_amount <= 0;

---------------------------------------------

-- 2. Very high order totals
SELECT
    payment_id,
    order_id,
    food_amount,
    delivery_fee,
    total_amount
FROM raw.payments
WHERE total_amount > 100
ORDER BY total_amount DESC;

---------------------------------------------

-- 3. Very long delivery distances
SELECT
    delivery_id,
    order_id,
    courier_id,
    distance_km,
    estimated_delivery_minutes,
    actual_delivery_minutes,
    delivery_status
FROM raw.deliveries
WHERE distance_km > 20
ORDER BY distance_km DESC;

---------------------------------------------

-- 4. Very short or very long actual delivery time
SELECT
    delivery_id,
    order_id,
    distance_km,
    estimated_delivery_minutes,
    actual_delivery_minutes,
    pickup_time,
    delivered_time,
    delivery_status
FROM raw.deliveries
WHERE actual_delivery_minutes < 5
   OR actual_delivery_minutes > 120
ORDER BY actual_delivery_minutes DESC;
-- 159 records with very short/long actual delivery time

---------------------------------------------

-- 5. Unrealistic restaurant ratings
SELECT
    restaurant_id,
    restaurant_name,
    avg_rating
FROM raw.restaurants
WHERE avg_rating < 1
   OR avg_rating > 5;

---------------------------------------------

-- 6. Suspicious restaurant commission rates
SELECT
    restaurant_id,
    restaurant_name,
    restaurant_tier,
    commission_rate
FROM raw.restaurants
WHERE commission_rate < 0
   OR commission_rate > 0.4
ORDER BY commission_rate DESC;

---------------------------------------------

-- 7. Users with unusually high number of orders
SELECT
    user_id,
    COUNT(*) AS total_orders
FROM raw.orders
GROUP BY user_id
HAVING COUNT(*) > 100
ORDER BY total_orders DESC;

---------------------------------------------

-- 8. Restaurants with unusually high number of orders
SELECT
    restaurant_id,
    COUNT(*) AS total_orders
FROM raw.orders
GROUP BY restaurant_id
HAVING COUNT(*) > 500
ORDER BY total_orders DESC;