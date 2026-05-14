## 01. Row count checks

| Table | Row count | Comment |
|---|---:|---|
| users | 1,574 | 
| restaurants | 85 | 
| orders | 5,310 | 
| payments | 5,310 | 
| deliveries | 5,310 | 

No unexpected row loss was detected during import.

## 02. Null checks

### Expected NULLs

- `users.subscription_start_date` contains NULLs for users who are not subscribers.
- `orders.refund_reason` contains NULLs for orders that were not refunded.

### Finding

In `deliveries`, missing values were found in:
- `pickup_time`: 482
- `delivered_time`: 482
- `actual_delivery_minutes`: 400

The difference between missing delivery timestamps and missing actual delivery duration requires additional business logic checks.

Potential issue:
Some records may have `actual_delivery_minutes` populated even when pickup or delivered timestamps are missing.

## 03. Duplicate checks

Checked duplicate primary keys in all raw tables:
- user_id
- restaurant_id
- order_id
- delivery_id
- payment_id

No duplicate primary keys were found.

## 04. Referential integrity checks

Checked relationships between:
- orders → users
- orders → restaurants
- payments → orders
- deliveries → orders

Additional checks were performed to identify orders without payment or delivery records.

No broken relationships were detected.

## 05. Temporal Checks

Validated date and timestamp consistency across users, orders, and deliveries.

### Finding

- 14 users have subscription dates earlier than their account registration date. 
- 73 delivery records contain invalid timestamp sequences where `delivered_time < pickup_time`. 
- 218 delivery records have inconsistencies between calculated delivery duration and `actual_delivery_minutes`.  
    Further inspection showed two types of issues:
  - incorrect `actual_delivery_minutes` values, such as negative or unrealistically high durations;
  - invalid timestamp sequences where `delivered_time` is earlier than `pickup_time`.
### Suggested handling

Invalid temporal records should be corrected or excluded in the staging layer before building analytical marts and dashboards.



