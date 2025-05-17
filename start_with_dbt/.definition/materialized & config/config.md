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

### materialized
Get more info in the follow link: [materialized](definition/threads.md)

### alias
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

### schema 
`schema` Specifies the schema name where the model will be created. If omitted, dbt uses the default schema from `profiles.yml`.
```sql
{{ config(schema='analytics') }}
```

### database
`database` Specifies the database where the model will be stored (used in multi-database setups).
```sql
{{ config(database='warehouse') }}
```

### on_schema_change
`on_schema_change` For incremental models, defines what dbt should do if the schema changes (for example, columns are added or removed) <br>
* `"fail"` (default): raise an error and stop the run if the schema has changed
* `"ignore"`: ignore schema changes and continue running the incremental model without making any alterations to the existing table schema
* `"append_new_columns"`: automatically add any new columns found in the source data to the existing table schema during incremental runs (columns that are dropped from the source are not removed from the table.)
```sql
{{ config(
    materialized='incremental',
    on_schema_change='append_new_columns'
) }}

select * from source_table
```

### cluster_by
`cluster_by` Specifies one or more columns to cluster the table by in BigQuery. Clustering improves query performance by sorting the data internally by these columns, reducing data scanned.<br>
Best practice: Use columns that are commonly used in `WHERE`, `JOIN`, or `GROUP BY` clauses.
```sql
{{ config(
    materialized='table',
    cluster_by=['customer_id', 'order_date']
) }}

select * from orders
```

### partition_by
`partition_by` Defines a partition column for partitioned tables in BigQuery. Partitioning helps manage and query large tables by splitting data into partitions based on date or integer range.<br>
* `field`: the name of the column to partition by
* `data_type`: "date", "timestamp", "datetime"
* `granularity` (optional): "day", "month", "year" — default is "day"
```sql
{{ config(
    materialized='table',
    partition_by={
      "field": "created_date",
      "data_type": "date", 
      "granularity": "day"
    }
) }}

select * from events
```

### unique_key
`unique_key` Specifies the primary key column(s) for incremental models. dbt uses this key to identify new or updated rows when running incremental models.

```sql
{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

select * from raw_orders
```

### pre-hook / Ppst-hook
`pre-hook / post-hook` 	SQL statements executed before (pre-hook) or after (post-hook) the model runs. Useful for auditing or cleanup.
```sql
{{ config(
  pre_hook=["DELETE FROM staging.logs WHERE date < CURRENT_DATE() - 30"],
  post_hook=["INSERT INTO audit_log(model_name) VALUES ('my_model')"]
) }}
```

### grants
`grants` Specifies database permissions to grant to users or groups after model creation.
```sql
{{ config(grants={"select": ["data_team", "analyst"]}) }}
```

### enabled
`enabled` If set to false, the model is skipped during dbt run.
```sql
{{ config(enabled=false) }}

```

### persist_docs
`persist_docs` Enables writing `description` metadata of models and columns into the database for documentation purposes.
```sql
{{ 
    config(persist_docs={"relation": true -- persist description on the model/table/view
                        , "columns": true -- persist description on the columns
    }) }}
{{ doc("orders_model") }}
select
order_id, -- {{ doc("order_id_column") }}
customer_id
from raw.orders
```

### tags
`tags` Tags are used to group or filter models during execution or in documentation.
```sql
{{ config(tags=["monthly", "revenue"]) }}
```