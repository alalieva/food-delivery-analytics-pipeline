## Marts Validation Checks

Additional validation checks were performed after creating analytical marts to ensure data consistency, correct aggregation logic.

The validation process included:

### Grain Validation

Each mart was validated to ensure the correct granularity:

- `marts_orders` → one row per order
- `mart_users` → one row per user
- `mart_restaurants` → one row per restaurant
- `mart_daily_metrics` → one row per calendar date

`COUNT(*)` was compared against `COUNT(DISTINCT primary_key)` to confirm uniqueness.

---

### Revenue Consistency Validation

Aggregated financial metrics were compared across marts to verify calculation consistency, including:

- gross order value
- commission revenue
- restaurant payout amount

The values were expected to match after excluding invalid records.

---

### Order Count Consistency

Order counts were validated across marts to ensure that aggregations remained accurate after grouping by:

- users
- restaurants
- dates

---

### Data Quality Validation

Rows marked with `has_data_quality_issue = TRUE` were intentionally excluded from analytical marts to prevent invalid records from affecting business KPIs and dashboard calculations.

Additional checks were performed for:

- NULL key fields
- negative financial values
- unexpected user segment values

---

These validation checks help ensure that the marts are analytically reliable and ready for downstream reporting and dashboards.
