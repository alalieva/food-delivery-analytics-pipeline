-- Staging model for restaurants table

DROP TABLE  IF EXISTS staging.stg_restaurants;

CREATE TABLE staging.stg_restaurants AS
SELECT 
    restaurant_id,	
    TRIM(restaurant_name) AS restaurant_name,
    LOWER(TRIM(cuisine_type)) AS cuisine_type,
    INITCAP(TRIM(city)) AS city,	
    avg_rating::NUMERIC(3, 2) AS avg_rating,
    LOWER(TRIM(restaurant_tier)) AS restaurant_tier,
    commission_rate::NUMERIC(4, 2) AS commission_rate
    
FROM raw.restaurants