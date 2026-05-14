# Staging Layer

The staging layer is the first transformation step after loading raw CSV files into PostgreSQL.

Main objectives of the staging layer:

- standardize column names and data types
- clean and normalize text fields
- convert raw string dates into proper `DATE` and `TIMESTAMP` types
- add helper date fields for future analysis
- preserve original business data without aggregation
- flag potential data quality issues

At this stage, no business KPIs or aggregations are calculated yet.

---

# 01_stg_users.sql

Purpose: prepare user data for analytical processing.

Main transformations:

- trimmed extra spaces from text fields
- standardized emails using lowercase format
- standardized city names
- converted date fields to `DATE`
- converted subscription flag to `BOOLEAN`
- added a quality flag for invalid subscription timelines

Data quality checks identified records where:  
`subscription_start_date < signup_date`

The staging model preserves original values and adds a helper flag:   
`has_subscription_before_signup`

This allows invalid records to be easily filtered and analyzed in downstream models.

---

# 02_stg_orders.sql

Purpose: prepare order data.

Main transformations:

- converted `order_datetime` to `TIMESTAMP`
- standardized order status values
- cleaned refund reason text
- created helper date fields for reporting and aggregations

Helper fields added:

```sql
order_date
order_year
order_month
```

These fields simplify:
- time-series analysis
- monthly aggregations
- cohort analysis

The staging model keeps one row per order and does not perform aggregations.

---

# 03_stg_payments.sql

Purpose: prepare payment data.

Main transformations:

- standardized payment method values
- standardized payment status values
- converted currency codes to uppercase format
- converted monetary fields to numeric format


The staging model keeps one row per payment and does not perform aggregations.

---

# 04_stg_deliveries.sql

Purpose: prepare delivery and logistics data.

Main transformations:

- converted distance values to numeric format
- converted delivery duration fields to integer
- converted pickup and delivery timestamps to `TIMESTAMP`
- standardized delivery status values
- added helper quality flags for invalid delivery records

Data quality checks identified several delivery timeline issues, including:   
`delivered_time < pickup_time`  
and mismatches between recorded delivery duration and actual timestamp difference.

The staging model preserves original values and adds helper flags:

```sql
has_delivered_before_pickup
has_invalid_delivery_duration
has_unusual_delivery_duration
```

These flags simplify downstream filtering and anomaly analysis.

The staging model keeps one row per delivery and does not perform aggregations.
