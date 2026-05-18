-- Check duplicate primary keys in raw tables

------------

SELECT user_id,
    count(*) AS duplicate_count
FROM raw.users
GROUP BY user_id
HAVING count(*)>1;

------------

SELECT order_id,
    count(*) AS duplicate_count
FROM raw.orders
GROUP BY order_id
HAVING count(*)>1;


------------

SELECT delivery_id,
    count(*) AS duplicate_count
FROM raw.deliveries
GROUP BY delivery_id
HAVING count(*)>1;

------------

SELECT payment_id,
    count(*) AS duplicate_count
FROM raw.payments
GROUP BY payment_id
HAVING count(*)>1;

------------

SELECT restaurant_id,
    count(*) AS duplicate_count
FROM raw.restaurants
GROUP BY restaurant_id
HAVING count(*)>1;