# Model configurations
```sql
{{
   config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge',
    on_schema_change='append_new_columns',
    alias='orders_incremental',
    schema='analytics',
    tags=['orders', 'monthly'],
    cluster_by=['order_date'],
    partition_by={'field': 'order_date', 'data_type': 'date'},
    post_hook="GRANT SELECT ON {{ this }} TO ANALYST_ROLE"
   ) 
}}
```

### 1. Materialized
Get more info in the follow link: [materialized](definition/threads.md)

### 2. Cleanup / View Options
`alias` config is used to set a custom name for the final table or view that dbt builds — instead of using the model file name. <br>
By default, if your model file is named:
```bash
models/orders_summary.sql
```
Then dbt will create a table or view named:
```bash
orders_summary
```
But with alias, you can override that default name:
```sql
{{ config(
    alias='daily_orders'
) }}
```
This will create a table or view named `daily_orders` instead.
