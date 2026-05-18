-- Staging model for orders table

DROP TABLE IF EXISTS staging.stg_orders;

CREATE TABLE staging.stg_orders AS
SELECT
    order_id,
    user_id,
    restaurant_id,
    order_datetime::TIMESTAMP AS order_datetime,

    DATE(order_datetime) AS order_date,
    EXTRACT(YEAR FROM order_datetime::TIMESTAMP) AS order_year,
    EXTRACT(MONTH FROM order_datetime::TIMESTAMP) AS order_month,

    LOWER(TRIM(order_status)) AS order_status,
    TRIM(refund_reason) AS refund_reason

FROM raw.orders;