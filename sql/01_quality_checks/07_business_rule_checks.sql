-- 1. Delivered orders without successful payment
SELECT
    o.order_id,
    o.order_status,
    p.payment_status
FROM raw.orders o
LEFT JOIN raw.payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
  AND p.payment_status <> 'paid';



-- 2. Cancelled orders with successful payment
SELECT
    o.order_id,
    o.order_status,
    p.payment_status,
    p.total_amount
FROM raw.orders o
LEFT JOIN raw.payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'cancelled'
  AND p.payment_status = 'paid';



-- 3. Refunded payments without cancelled order
SELECT
    o.order_id,
    o.order_status,
    p.payment_status,
    p.total_amount
FROM raw.payments p
LEFT JOIN raw.orders o
    ON p.order_id = o.order_id
WHERE p.payment_status = 'refunded'
  AND o.order_status <> 'cancelled';



-- 4. Delivered orders without completed delivery
SELECT
    o.order_id,
    o.order_status,
    d.delivery_status,
    d.pickup_time,
    d.delivered_time
FROM raw.orders o
LEFT JOIN raw.deliveries d
    ON o.order_id = d.order_id
WHERE o.order_status = 'delivered'
  AND d.delivery_status <> 'delivered';



-- 5. Non-delivered orders with delivered delivery status
SELECT
    o.order_id,
    o.order_status,
    d.delivery_status
FROM raw.orders o
LEFT JOIN raw.deliveries d
    ON o.order_id = d.order_id
WHERE o.order_status <> 'delivered'
  AND d.delivery_status = 'delivered';



-- 6. Cancelled orders without refund reason
SELECT
    order_id,
    order_status,
    refund_reason
FROM raw.orders
WHERE order_status = 'cancelled'
  AND refund_reason IS NULL;



-- 7. Non-cancelled orders with refund reason
SELECT
    order_id,
    order_status,
    refund_reason
FROM raw.orders
WHERE order_status <> 'cancelled'
  AND refund_reason IS NOT NULL;



-- 8. Subscribers without subscription start date
SELECT
    user_id,
    full_name,
    is_subscriber,
    subscription_start_date
FROM raw.users
WHERE is_subscriber = TRUE
  AND subscription_start_date IS NULL;



-- 9. Non-subscribers with subscription start date
SELECT
    user_id,
    full_name,
    is_subscriber,
    subscription_start_date
FROM raw.users
WHERE is_subscriber = FALSE
  AND subscription_start_date IS NOT NULL;


 
-- 10. Delivery fee does not match subscription logic
SELECT
    o.order_id,
    u.user_id,
    u.is_subscriber,
    p.food_amount,
    p.delivery_fee,
    CASE
        WHEN u.is_subscriber = TRUE AND p.food_amount < 15 THEN 1.49
        WHEN u.is_subscriber = TRUE AND p.food_amount >= 15 THEN 0
        WHEN u.is_subscriber = FALSE THEN 3.99
    END AS expected_delivery_fee
FROM raw.orders o
LEFT JOIN raw.users u
    ON o.user_id = u.user_id
LEFT JOIN raw.payments p
    ON o.order_id = p.order_id
WHERE p.delivery_fee <> (CASE
    WHEN u.is_subscriber = TRUE AND p.food_amount < 15 THEN 1.49
    WHEN u.is_subscriber = TRUE AND p.food_amount >= 15 THEN 0
    WHEN u.is_subscriber = FALSE THEN 3.99
END);



-- 11. Total paid amount is not equal to food amount + delivery fee
SELECT *
FROM raw.payments
WHERE payments.total_amount <> payments.food_amount + payments.delivery_fee;



-- 12. Commission rate does not match restaurant tier
SELECT 
    restaurant_tier,
    commission_rate,
    CASE 
        WHEN restaurant_tier = 'small_local' THEN 0.15
        WHEN restaurant_tier = 'medium' THEN 0.20
        WHEN restaurant_tier = 'premium' THEN 0.25
    END AS expected_commission_rate
FROM raw.restaurants 
WHERE commission_rate <> CASE  
    WHEN restaurant_tier = 'small_local' THEN 0.15
        WHEN restaurant_tier = 'medium' THEN 0.20
        WHEN restaurant_tier = 'premium' THEN 0.25
    END

