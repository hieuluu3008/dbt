# Materialized
refers to **how a model's SQL query is executed and stored** in the database. Different materializations control whether the query runs dynamically or saves data for better performance.
* Optimize Query Performance – Store data instead of recalculating it every time.
* Reduce Compute Costs – Avoid running expensive transformations repeatedly.
* Control Data Persistence – Choose whether to store results as tables, views, or incremental updates.

### Type of Materializations
You can specify the materialization in a model's `.yml` file or inside the `.sql` file using the config function.
1. View (default)
* Create a SQL view.<br>
Ex:
```sql
{{ config(materialized='view') }}

SELECT * FROM raw_orders
```

2. Table
* Create a SQL  physical table.<br>
Ex:
```sql
{{ config(materialized='table') }}

SELECT
    customer_id,
    SUM(order_value) AS total_spent
FROM {{ ref('stg_orders') }}
GROUP BY customer_id
```

3. Incremental
* Runs the query and only updates new/changed rows instead of recreating the whole table.
* Efficient for large datasets that change over time.<br>
Ex:
```sql
{{ config(materialized='incremental', unique_key='order_id') }}

SELECT *
FROM {{ ref('stg_orders') }}
WHERE order_date >= CURRENT_DATE - INTERVAL '7 days'

{% if is_incremental() %}
  -- Only insert new rows that don’t exist yet
  AND order_id NOT IN (SELECT order_id FROM {{ this }})
{% endif %}
```

4. Ephemeral
* Not create a table or view.
* Function like CTE in SQL.
* Useful for reusable logic that doesn’t need storage.<br>
Ex:
```sql
{{ config(materialized='ephemeral') }}

SELECT order_id, price * 0.9 AS discounted_price
FROM {{ ref('stg_orders') }}
```
