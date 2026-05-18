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

## 6. Outlier Checks

The purpose of this stage is to identify unusually high, low, or suspicious values that may indicate data quality issues, unrealistic synthetic records, or rare business scenarios.

The following checks were performed:

- Negative or zero payment amounts
- Extremely high order totals
- Unrealistic delivery distances
- Extremely short or long delivery durations
- Invalid restaurant ratings
- Suspicious commission rates
- Users with unusually high order counts
- Restaurants with unusually high order volumes

### Key Findings

- 159 delivery records contained unusually short or long delivery durations.

Outliers were not automatically removed because extreme values can sometimes represent valid business events (e.g. delayed deliveries during peak hours or holidays). These records were flagged for further inspection instead.

## 7. Business Rule Checks

The purpose of this stage is to validate whether the dataset follows expected business logic and operational rules.

The following checks were performed:
- Delivered orders without successful payments
- Cancelled orders with successful payments
- Refunded payments without cancelled orders
- Inconsistent order and delivery statuses
- Missing refund reasons for cancelled orders
- Invalid subscription logic
- Delivery fee validation based on subscription status and food amount
- Total amount validation (`food_amount + delivery_fee = total_amount`)
- Restaurant commission validation based on restaurant tier

### Key Findings

- No business rule violations were detected in the dataset.
- Delivery fees correctly matched subscription conditions and order values.
- Total payment amounts were consistent with calculated totals.
- Restaurant commission rates correctly matched restaurant tiers.
- Order, payment, and delivery statuses were logically consistent across related tables.

These checks confirmed that the generated dataset follows the intended business rules and operational logic of the food delivery platform.
