## 01. Row count checks

| Table | Row count | Comment |
|---|---:|---|
| users | 1,574 | Dimension table |
| restaurants | 85 | Dimension table |
| orders | 5,390 | Main fact table |
| payments | 5,310 | Not equal to orders; requires referential/business logic check |
| deliveries | 5,310 | Not equal to orders; requires referential/business logic check |

### Finding
The number of records in `orders`, `payments`, and `deliveries` is not identical.

This may be expected if:
- cancelled orders do not always have delivery records;
- failed or unpaid orders may not have successful payment records;
- refunds/cancellations are stored differently across tables.

Further checks are required:
- verify whether every `payment.order_id` exists in `orders`;
- verify whether every `delivery.order_id` exists in `orders`;
- identify orders without payments;
- identify orders without deliveries;
- compare missing payments/deliveries by `order_status`.

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
