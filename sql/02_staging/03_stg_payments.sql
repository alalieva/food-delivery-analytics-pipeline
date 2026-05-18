-- Staging model for payments table

DROP TABLE IF EXISTS staging.stg_payments;

CREATE TABLE staging.stg_payments AS
SELECT
    payment_id,
    order_id,

    LOWER(TRIM(payment_method)) AS payment_method,
    LOWER(TRIM(payment_status)) AS payment_status,
    UPPER(TRIM(currency)) AS currency,

    food_amount::NUMERIC(10, 2) AS food_amount,
    delivery_fee::NUMERIC(10, 2) AS delivery_fee,
    total_amount::NUMERIC(10, 2) AS total_amount

FROM raw.payments;