# Schema Notes

## users

| column | description |
|---|---|
| user_id | unique user identifier |
| full_name | User full name |
| email | User email address |
| city | City where the user is located |
| signup_date | Platform registration date |
| is_subscriber | Flag indicating whether the user is subscribed to the premium subscription |
| subscription_start_date | Subscription activation date |


## orders

| column | description |
|---|---|
| order_id | Unique identifier for each order |
| user_id | Identifier of the user who placed the order |
| restaurant_id | Identifier of the restaurant associated with the order |
| order_datetime | Date and time when the order was created |
| order_status | Final order status in the delivery lifecycle ( `delivered`, `cancelled` )  |
| refund_reason | Reason for refund or cancellation if applicable ( `customer_complaint`, `wrong_items`, `damaged_food`, `late_delivery` ) |


## payments

| column | description |
|---|---|
| payment_id | Unique identifier for each payment transaction |
| order_id | Reference to the related order |
| payment_method | Payment method used by the customer ( `card`, `paypal`, `google_pay`, `apple_pay` ) |
| payment_status | Final payment status (  `paid`, `refunded` ) |
| currency | Currency used for the transaction |
| food_amount | Cost of food items before delivery fees |
| delivery_fee | Delivery charge paid by the customer ( `0`, `1.49`, `1.99` ) |
| total_amount | Total transaction amount including delivery fee | 


## deliveries

| column | description |
|---|---|
| delivery_id | Unique identifier for each delivery |
| order_id | Reference to the related order |
| courier_id | Identifier of the courier assigned to the delivery |
| distance_km | Delivery distance in kilometers |
| estimated_delivery_minutes | Estimated delivery duration in minutes |
| pickup_time | Timestamp when the courier picked up the order |
| delivered_time | Timestamp when the order was delivered to the customer |
| delivery_status | Final delivery status ( `delivered`, `cancelled` ) |
| actual_delivery_minutes | Actual delivery duration in minutes |


## restaurants

| column | description |
|---|---|
| restaurant_id | Unique identifier for each restaurant |
| restaurant_name | Restaurant display name |
| cuisine_type | Type of cuisine offered by the restaurant ( `Asian Fusion`, `Italian`, `Valencian`, `Mexican`, `Mediterranean`, `Japanese`, `Spanish` ) |
| city | City where the restaurant operates ( `Madrid`, `Barcelona`, `Valencia` ) |
| avg_rating | Average customer rating of the restaurant |
| restaurant_tier | Restaurant business segment ( `small_local`, `medium`, `premium` ) |
| commission_rate | Platform commission percentage charged to the restaurant ( `0.15` for `small_local`, `0.20` for `medium`, `0.25` for `premium` ) |
