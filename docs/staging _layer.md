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
