-- Staging model for deliveries table
DROP TABLE IF EXISTS staging.stg_deliveries;

CREATE TABLE staging.stg_deliveries AS 
SELECT 
    delivery_id,
    order_id,
    courier_id,
    
    distance_km::NUMERIC(6, 2) AS distance_km,
    estimated_delivery_minutes::INTEGER AS estimated_delivery_minutes,
    
    pickup_time::TIMESTAMP AS pickup_time,
    delivered_time::TIMESTAMP AS delivered_time,

    LOWER(TRIM(delivery_status)) AS delivery_status,

    actual_delivery_minutes::INTEGER AS actual_delivery_minutes,

    CASE
        WHEN delivered_time::TIMESTAMP < pickup_time::TIMESTAMP
            THEN TRUE
        ELSE FALSE
    END AS has_delivered_before_pickup,

    CASE
        WHEN actual_delivery_minutes::INTEGER <> 
             ROUND(EXTRACT(EPOCH FROM (delivered_time::TIMESTAMP - pickup_time::TIMESTAMP)) / 60)
            THEN TRUE
        ELSE FALSE
    END AS has_invalid_delivery_duration,

    CASE
        WHEN actual_delivery_minutes::INTEGER < 5
            OR actual_delivery_minutes::INTEGER > 120
            THEN TRUE
        ELSE FALSE
    END AS has_unusual_delivery_duration

FROM raw.deliveries;

