SELECT 'users' AS table_name, COUNT (*) AS row_count FROM raw.users 
UNION ALL 
SELECT 'orders', COUNT (*) FROM raw.orders 
UNION ALL
SELECT 'deliveries', COUNT (*) FROM raw.deliveries
UNION ALL 
SELECT 'payments', COUNT (*) FROM raw.payments
UNION ALL 
SELECT 'restaurants', COUNT (*) FROM raw.restaurants