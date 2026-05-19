# 🛵 Food-Delivery-Analytics-Pipeline

## Table of Contents
- [Project Overview](#project-overview)
  - [Repository structure](#repository-structure)
- [Business Context](#business-context)
- [Data Sources](#data-sources)
- [Project Workflow](#project-workflow)
  - [1. Raw Data Generation](#1-raw-data-generation)
  - [2. Data Quality Checks](#2-data-quality-checks)
  - [3. Staging Layer](#3-staging-layer)
  - [4. Analytical Marts](#4-analytical-marts)
- [Final Mart Tables](#final-mart-tables)
- [SQL Scripts](#sql-scripts)
- [Documentation](#documentation)
- [Tools Used](#tools-used)
- [Project Outcome](#project-outcome)

## Project Overview

This project demonstrates a full data analytics pipeline for a synthetic food delivery business.

The goal of the project is to transform raw operational CSV data into clean analytical marts that can be used for business reporting, dashboarding, and performance analysis.

The pipeline covers the full workflow:

**Raw CSV data → PostgreSQL → Data Quality Checks → Staging Layer → Analytical Marts → ready datasets**

### _Repository structure_
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

⚠️ Key findings included:

🔸 14 users had subscription dates earlier than their signup dates  
🔸 73 delivery records had invalid timestamp sequences  
🔸 218 delivery records had mismatches between timestamps and stored delivery duration  
🔸 159 delivery records contained unusually short or long delivery durations  

A summary of detected issues and findings is available here:

📄 [Data Quality Summary](docs/01_data_quality_summary.md)

The complete set of SQL validation scripts is available here:

📂 [SQL Quality Checks](sql/01_quality_checks/)

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

Description of staging transformations and standardization logics available here:

📄  [Documentation Staging_Layer](docs/02_staging_layer.md)


The complete set of SQL scripts is available here:

📂 [SQL Staging](sql/02_staging/)


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

📄 [Documentation Marts](docs/03_marts.md)

The complete set of SQL scripts is available here:

📂 [SQL Marts](sql/03_marts/)

Final Mart tables are available here:

📊  [View  Mart Table](data/03_marts/)


#### Example Business Metrics 

The marts include metrics such as:

🔹 total orders  
🔹 delivered orders  
🔹 cancelled orders  
🔹 refunded orders  
🔹 gross order value  
🔹 food sales   
🔹 delivery fee revenue  
🔹 restaurant commission revenue  
🔹 average order value  
🔹 average delivery duration  
🔹 subscriber vs non-subscriber behavior  
🔹 restaurant performance by city and cuisine  

#### Data Sources Used

The mart layer combines data from:

- `stg_users`
- `stg_orders`
- `stg_payments`
- `stg_deliveries`
- `stg_restaurants`

#### Validation

Final marts were additionally validated to ensure:

- aggregation consistency
- correct KPI calculations
- valid business logic
- accurate joins between entities

Detailed validation results are available here:

📄 [Marts Validation Checks](docs/04_marts_validation_checks.md)

---

## Final Mart Tables

The pipeline produces several business-ready analytical datasets optimized for reporting and dashboarding.

| Mart Table | Link| Grain | Purpose |
|---|---|---|---|
| `mart_orders` | [mart_orders.csv](data/03_marts/mart_orders.csv) | One row per order | Core analytical fact table combining order, payment, and delivery data |
| `mart_user_metrics` | [mart_users.csv](data/03_marts/mart_users.csv) | One row per user | User behavior and spending KPIs |
| `mart_restaurants` | [mart_restaurants.csv](data/03_marts/mart_restaurants.csv) | One row per restaurant | Restaurant sales and commission analysis |
| `mart_daily_metrics` | [mart_daily_metrics.csv](data/03_marts/mart_daily_metrics.csv) | One row per day | Daily business KPIs for time-series analysis |

---

## SQL Scripts

### Quality Checks
📂 [quality_checks/](sql/01_quality_checks/)

### Staging Layer
- [01_stg_users.sql](sql/02_staging/01_stg_users.sql)
- [02_stg_orders.sql](sql/02_staging/02_stg_orders.sql)
- [03_stg_payments.sql](sql/02_staging/03_stg_payments.sql)
- [04_stg_deliveries.sql](sql/02_staging/04_stg_deliveries.sql)
- [05_stg_restaurants.sql](sql/02_staging/05_stg_restaurants.sql)  
  
### Analytical Marts
- [01_mart_orders.sql](sql/03_marts/01_mart_orders.sql)
- [02_mart_user_metrics.sql](sql/03_marts/02_mart_user_metrics.sql)
- [03_mart_restaurant_metrics.sql](sql/03_marts/03_mart_restaurant_metrics.sql)
- [04_mart_daily_metrics.sql](sql/03_marts/04_mart_daily_metrics.sql)
- [marts_validation.sql](sql/03_marts/marts_validation.sql)

---

## Documentation

Detailed documentation for each pipeline stage is available below:

| Document | Description |
|---|---|
| [01_data_quality_summary.md](docs/01_data_quality_summary.md) | Summary of detected data quality issues and validation results |
| [02_staging_layer.md](docs/02_staging_layer.md) | Description of staging transformations and standardization logic |
| [03_marts.md](docs/03_marts.md) | Mart layer design, KPI logic, and aggregation strategy |
| [04_marts_validation_checks.md](docs/04_marts_validation_checks.md) | Validation checks applied to final mart datasets |
| [schema_notes.md](docs/schema_notes.md) | Table schemas and column descriptions |

---

## Tools Used 
- PostgreSQL
- SQL
- pgAdmin
- VS Code
- Git / GitHub
- Tableau

---

## Project Outcome  

The project simulates a real-world analytics engineering workflow used in modern data teams.

It demonstrates my ability to:

- work with raw operational datasets
- identify and validate data quality issues
- design structured staging layers
- build business-ready analytical marts
- implement business logic in SQL
- prepare scalable datasets for BI reporting

The resulting mart layer provides a clean analytical foundation for operational reporting, customer analytics, restaurant performance monitoring, and financial KPI tracking.
