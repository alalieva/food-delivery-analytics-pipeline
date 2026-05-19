# 🛵 Food-Delivery-Analytics-Pipeline

## Project Overview

This project demonstrates a full data analytics pipeline for a synthetic food delivery business.

The goal of the project is to transform raw operational CSV data into clean analytical marts that can be used for business reporting, dashboarding, and performance analysis.

The pipeline covers the full workflow:

**Raw CSV data → PostgreSQL → Data Quality Checks → Staging Layer → Analytical Marts → ready datasets**

_Repository structure_
```text
food-delivery-analytics-pipeline/
│
├── data/
│   ├── 01_raw/                       # Original CSV files
│   ├── 02_staging/                   # Cleaned staging outputs
│   └── 03_marts/                     # Final analytical datasets
│
├── sql/
│   ├── 01_quality_checks/            # Data quality validation queries
│   ├── 02_staging/                   # Staging SQL scripts
│   └── 03_marts/                     # Mart creation SQL scripts
│
├── docs/
│   ├── schema_notes.md               # Table and column descriptions
│   ├── 01_data_quality_summary.md
│   ├── 02_staging_layer.md
│   ├── 03_marts.md
│   └── 04_marts_validation_checks.md
│
├── README.md
└── .gitignore
```
---

## Business Context

The dataset represents a food delivery platform operating in several Spanish cities:

- Barcelona
- Madrid
- Valencia

The business involves:

- users placing food orders
- restaurants receiving orders
- couriers delivering orders
- payments and refunds
- delivery fees and restaurant commissions
- subscription-based delivery fee logic

---

## Data Sources

| Table | Description |
|---|---|
| `users` | Customer information |
| `restaurants` | Restaurant details |
| `orders` | Order records |
| `payments` | Payment transactions |
| `deliveries` | Delivery operations |

For full column descriptions and schema details see:

📄 [Schema Notes](docs/schema_notes.md)

---

## Project Workflow

### 1. Raw Data Generation

Synthetic data was generated to simulate a realistic food delivery business.

The dataset includes intentional data quality issues, such as:

- invalid subscription dates
- inconsistent delivery timestamps
- mismatched delivery duration values
- cancelled and refunded orders
- realistic business rules for delivery fees and commission rates

Raw data samples are available here:

📂  [Raw CSV Data](data/01_raw/)

---

### 2. Data Quality Checks

Raw operational tables were validated before transformation into staging and mart layers.

Validation included:

- duplicate checks
- NULL checks
- foreign key validation
- timestamp consistency checks
- business rule verification
- payment reconciliation checks

Key findings included:

- 14 users had subscription dates earlier than their signup dates
- 73 delivery records had invalid timestamp sequences
- 218 delivery records had mismatches between timestamps and stored delivery duration
- 159 delivery records contained unusually short or long delivery durations


The complete set of SQL validation scripts is available here:

📂 [SQL Quality Checks](sql/01_quality_checks/)

A summary of detected issues and findings is available here:

📄 [Data Quality Summary](docs/01_data_quality_summary.md)


---

### 3. Staging Layer

The staging layer standardizes and prepares raw data for analytics.

Main transformations:

- renamed columns into consistent `snake_case`
- cast fields into correct data types
- added helper boolean flags
- added date-based helper fields
- standardized business logic fields
- preserved raw business meaning while making tables easier to query

Staging tables:

| Staging Table    | Source |
|------|---|
| `stg_users`       | `raw.users` |
| `stg_restaurants` | `raw.restaurants` |
| `stg_orders`      | `raw.orders` |
| `stg_payments`    | `raw.payments` |
| `stg_deliveries`  | `raw.deliveries` |

The complete set of SQL scripts is available here:

📂 [SQL Staging](sql/02_staging/)


Description of staging transformations and standardization logics available here:

📄  [Documentation Staging_Layer.md](docs/02_staging_layer.md)


Staging tables samples are available here:

📊  [View Sample Staging Table](data/02_staging/)


---

### 4. Analytical Marts

The mart layer transforms cleaned staging data into business-ready analytical datasets for reporting and dashboarding.

Created marts:

| Mart | Purpose |
|---|---|
| `mart_orders` | Order-level analytical dataset |
| `mart_users` | User KPIs and behavioral metrics |
| `mart_restaurants` | Restaurant performance analysis|
| `mart_daily_metrics` | Daily business KPIs for time-series analysis |

Mart Layer Documentation is here:

📄 [Documentation Marts.md](docs/03_marts.md)

The complete set of SQL scripts is available here:

📂 [SQL Marts](sql/03_marts/)


### Example Business Metrics

The marts include metrics such as:

- total orders
- delivered orders
- cancelled orders
- refunded orders
- gross order value
- food sales 
- delivery fee revenue
- restaurant commission revenue
- average order value
- average delivery duration
- subscriber vs non-subscriber behavior
- restaurant performance by city and cuisine

### Data Sources Used

The mart layer combines data from:

- `stg_users`
- `stg_orders`
- `stg_payments`
- `stg_deliveries`
- `stg_restaurants`

### Validation

Final marts were additionally validated to ensure:

- aggregation consistency
- correct KPI calculations
- valid business logic
- accurate joins between entities

Detailed validation results are available here:

📄 [04_marts_validation_checks.md](docs/04_marts_validation_checks.md)


---

## SQL Scripts

### Quality Checks
📂 [quality_checks/](sql/quality_checks/)

### Staging Layer
- [01_stg_users.sql](sql/staging/01_stg_users.sql)
- [02_stg_orders.sql](sql/staging/02_stg_orders.sql)
- [03_stg_payments.sql](sql/staging/03_stg_payments.sql)
- [04_stg_deliveries.sql](sql/staging/04_stg_deliveries.sql)
- [05_stg_restaurants.sql](sql/staging/05_stg_restaurants.sql)  
  
### Analytical Marts
- [01_mart_orders.sql](sql/03_marts/01_mart_orders.sql)
- [02_mart_user_metrics.sql](sql/03_marts/02_mart_user_metrics.sql)
- [03_mart_restaurant_metrics.sql](sql/03_marts/03_mart_restaurant_metrics.sql)
- [04_mart_daily_metrics.sql](sql/03_marts/04_mart_daily_metrics.sql)
- [marts_validation.sql](sql/03_marts/marts_validation.sql)

---

## Tools Used
- PostgreSQL
- SQL
- pgAdmin
- VS Code
- Git / GitHub
- Tableau

## Project Outcome

This project shows how raw operational data can be transformed into clean analytical datasets through a structured data pipeline.

It demonstrates my practical skills in:

- data quality checks
- SQL transformations
- staging layer design
- analytical mart creation
- business logic validation
- KPI preparation


The final marts are ready for business analysis.
