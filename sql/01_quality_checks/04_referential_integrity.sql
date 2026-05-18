-- Check relationships between raw tables

-- 1. Orders without matching user
SELECT
    COUNT(*) AS orders_without_user
FROM raw.orders o
LEFT JOIN raw.users u
    ON o.user_id = u.user_id
WHERE u.user_id IS NULL;

-- 2. Orders without matching restaurants
SELECT 
    COUNT(*) AS orders_without_restaurant
FROM raw.orders o
LEFT JOIN raw.restaurants r 
    ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

-- 3. Payments without matching order
SELECT
    COUNT(*) AS payments_without_order
FROM raw.payments p
LEFT JOIN raw.orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 4. Deliveries without matching order
SELECT
    COUNT(*) AS deliveries_without_order
FROM raw.deliveries d
LEFT JOIN raw.orders o
    ON d.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 5. Orders without payment
SELECT
    o.order_status,
    COUNT(*) AS orders_without_payment
FROM raw.orders o
LEFT JOIN raw.payments p
    ON o.order_id = p.order_id
WHERE p.order_id IS NULL
GROUP BY o.order_status
ORDER BY orders_without_payment DESC;

-- 6. Orders without delivery
SELECT
    o.order_status,
    COUNT(*) AS orders_without_delivery
FROM raw.orders o
LEFT JOIN raw.deliveries d
    ON o.order_id = d.order_id
WHERE d.order_id IS NULL
GROUP BY o.order_status
ORDER BY orders_without_delivery DESC;

