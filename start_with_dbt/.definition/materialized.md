# Materialized
refers to **how a model's SQL query is executed and stored** in the database. Different materializations control whether the query runs dynamically or saves data for better performance.
* Optimize Query Performance – Store data instead of recalculating it every time.
* Reduce Compute Costs – Avoid running expensive transformations repeatedly.
* Control Data Persistence – Choose whether to store results as tables, views, or incremental updates.

### Type of Materializations
You can specify the materialization in a model's `.yml` file or inside the `.sql` file using the config function.
1. View (default)
* Create a SQL view.
Ex:
```sql
{{ config(materialized='view') }}

SELECT * FROM raw_orders
```
