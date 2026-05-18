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
- delivered order (flag)
- cancelled order (flag)
- refunded order (flag)
- late delivery (flag)

The mart also stores data quality monitoring flags created during the staging layer, including:

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

### 02_mart_user_metrics.sql

This model creates a user-level analytical mart for customer behavior and revenue analysis.

**Grain:** one row per user.

The mart aggregates order, payment, and delivery information from the order-level mart `marts.marts_orders`.

The model calculates key customer metrics, including:

- total orders
- delivered orders
- cancelled orders
- refunded orders
- total revenue per user
- average order value (AOV)
- first and last order dates
- customer lifetime in days
- average delivery time
- late delivery count

Customer segmentation fields were also added:

- one_time
- regular (2-5 orders)
- power_user (more than 5 orders)

Segmentation is based on the number of completed orders per customer.

Additional behavioral indicators include:

- subscriber status
- refund behavior
- late delivery frequency
- order activity period

> The model aggregates only analytically valid records from `marts.marts_orders`.  
Rows marked with data quality issues were excluded from calculations using:  
`has_data_quality_issue = FALSE`  
This approach ensures that user-level KPIs and revenue metrics are calculated only from trusted and validated data.  
> 

The mart is designed to support:

- customer segmentation analysis
- retention and loyalty analysis
- LTV analysis
- revenue analysis by customer type
- subscription behavior analysis
- Tableau dashboards and KPI reporting

### 03_mart_restaurants.sql

This model creates a restaurant-level analytical mart for restaurant performance analysis.

**Grain:** one row per restaurant.

The mart aggregates validated order, payment, and delivery data from `marts.marts_orders`.

Rows marked with data quality issues were excluded from calculations using `has_data_quality_issue = FALSE`.   
This ensures that restaurant KPIs are calculated only from trusted and validated records.

The model includes restaurant attributes such as:

- restaurant name
- city
- cuisine type
- restaurant tier
- commission rate

The model calculates key restaurant performance metrics:

- total orders
- delivered orders
- cancelled orders
- refunded orders
- total food sales
- gross order value
- commission revenue
- restaurant payout amount
- average food basket value
- average order value
- first and last order dates
- average delivery time
- late delivery count

`total_food_sales` represents the total value of food sold by the restaurant.

`gross_order_value` represents the full customer-paid order value, including food amount and delivery fee.

`total_commission_revenue` represents the platform revenue earned from restaurant commissions.

`total_payout_amount` represents the amount paid out to restaurants after platform commission.

`avg_food_basket_value` shows the average food value per order, excluding delivery fees.

`avg_order_value` shows the average total customer check, including delivery fees.

This mart is designed to support:

- restaurant performance analysis
- cuisine and city comparison
- commission and payout analysis
- average check analysis
- delivery performance monitoring by restaurant
- dashboards and business KPI reporting

### 04_mart_daily_metrics.sql

This model creates a daily-level analytical mart for platform performance monitoring and time-series analysis.

**Grain:** one row per calendar date.

The mart aggregates validated order, payment, and delivery data from `marts.marts_orders`.

Rows marked with data quality issues were excluded from calculations using `has_data_quality_issue = FALSE`.  
This ensures that daily KPIs and operational metrics are calculated only from trusted and validated records.

The model calculates key daily platform metrics, including:

- total orders
- delivered orders
- cancelled orders
- refunded orders
- active users
- active restaurants
- total food sales
- gross order value
- delivery revenue
- commission revenue
- restaurant payout amount
- average food basket value
- average order value
- average delivery time
- late delivery count

`total_food_sales` represents the total value of food sold across all restaurants.

`gross_order_value` represents the total customer-paid order value, including food amount and delivery fees.

`total_delivery_revenue` represents revenue collected from delivery fees.

`total_commission_revenue` represents platform commission revenue earned from restaurants.

`total_payout_amount` represents the amount paid out to restaurants after commission deduction.

`avg_food_basket_value` shows the average food value per order, excluding delivery fees.

`avg_order_value` shows the average total customer check, including delivery fees.

The mart is designed to support:

- daily business KPI monitoring
- revenue trend analysis
- operational performance analysis
- active user and restaurant tracking
- delivery performance monitoring
- seasonality analysis
- dashboards and executive reporting
