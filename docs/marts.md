### 01_marts_orders.sql

This model creates the main order-level mart for the food delivery analytics pipeline.

**Grain:** one row per order.

The mart combines all cleaned staging tables into a single analytical dataset:

- `staging.stg_orders`
- `staging.stg_users`
- `staging.stg_restaurants`
- `staging.stg_payments`
- `staging.stg_deliveries`

The model enriches each order with:

- user information
- restaurant attributes
- payment details
- delivery metrics

Additional business calculations include:

- restaurant commission amount
- restaurant payout amount
- delivered order flag
- cancelled order flag
- refunded order flag
- late delivery flag

The mart also preserves data quality monitoring flags created during the staging layer, including:

- invalid subscription dates
- invalid delivery timestamp sequences
- mismatched delivery durations
- unusual delivery duration outliers

A combined field `has_data_quality_issue` was added to simplify filtering and quality monitoring in downstream analysis and dashboards.

The mart is designed to support:

- order volume analysis
- revenue and refund analysis
- delivery performance monitoring
- restaurant performance analysis
- customer behavior analysis
- dashboards and KPI reporting
