
-- Staging model for users table

DROP TABLE IF EXISTS staging.stg_users;


CREATE TABLE staging.stg_users AS
SELECT
    user_id,
    TRIM(full_name) AS full_name,
    LOWER(TRIM(email)) AS email,
    INITCAP(TRIM(city)) AS city,
    signup_date::DATE AS signup_date,
    is_subscriber::BOOLEAN AS is_subscriber,
    subscription_start_date::DATE AS subscription_start_date,
    CASE
        WHEN subscription_start_date::DATE < signup_date::DATE
            THEN TRUE
        ELSE FALSE
    END AS has_subscription_before_signup
FROM raw.users;