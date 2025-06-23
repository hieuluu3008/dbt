# Macro: set_sql_header()
*Available only in BigQuery, Snowflake, Redshift, ...*   

Used to execute SQL statements before the main query of a dbt model runs  

### Các use case:
1. Khai báo biến (DECLARE):
```sql
{% call set_sql_header(config) %}
    DECLARE start_date_ date DEFAULT '2023-01-01';
    DECLARE end_date_ date DEFAULT current_date();
{% endcall %}
```
2. Set session variables:
```sql
{% call set_sql_header(config) %}
    SET @@session.sql_mode = 'TRADITIONAL';
    SET time_zone = '+07:00';
{% endcall %}
```
3. Create temp function:
```sql
{% call set_sql_header(config) %}
    CREATE TEMP FUNCTION calculate_age(birth_date DATE)
    RETURNS INT64
    AS (
        DATE_DIFF(CURRENT_DATE(), birth_date, YEAR)
    );
{% endcall %}
```
### Vì sao nên sử dụng ?
* Khai báo trực tiếp (không dùng set_sql_header)  

Input:
```sql
DECLARE start_date_ date DEFAULT current_date();

SELECT * FROM my_table
WHERE date_col >= start_date_
```
Output:

```sql
-- dbt tạo ra wrap code như thế này
CREATE OR REPLACE TABLE my_schema.my_model AS (
    DECLARE start_date_ date DEFAULT current_date();  -- ❌ LỖI: DECLARE không thể ở đây
    
    SELECT * FROM my_table
    WHERE date_col >= start_date_
)
```
* Khai báo với set_sql_header  

Input:
```sql
{% call set_sql_header(config) %}
    DECLARE start_date_ date DEFAULT current_date();
{% endcall %}

SELECT * FROM my_table
WHERE date_col >= start_date_
```
Output:
```sql
-- Code từ set_sql_header được đặt ở ĐẦU, ngoài các wrapper
DECLARE start_date_ date DEFAULT current_date();

-- Sau đó mới đến các wrapper của dbt
CREATE OR REPLACE TABLE my_schema.my_model AS (
    SELECT * FROM my_table
    WHERE date_col >= start_date_  -- ✅ Biến có thể sử dụng được
)
```

### Kết hợp với Incremental
1. Khai báo biến
```sql
{% call set_sql_header(config) %}
    {% if is_incremental() %}
        DECLARE lookback_days INT64 DEFAULT 7;
        DECLARE start_date DATE DEFAULT DATE_SUB(CURRENT_DATE(), INTERVAL lookback_days DAY);
    {% else %}
        DECLARE start_date DATE DEFAULT DATE('2020-01-01');
    {% endif %}
{% endcall %}

SELECT *
FROM {{ source('raw', 'events') }}
WHERE event_date >= start_date
```

2. Tạo temp function
```sql
{% call set_sql_header(config) %}
    {% if is_incremental() %}
        -- Function tối ưu cho incremental run
        CREATE TEMP FUNCTION get_incremental_date()
        RETURNS DATE
        AS (
            DATE_SUB(CURRENT_DATE(), INTERVAL 3 DAY)
        );
    {% else %}
        -- Function cho full refresh
        CREATE TEMP FUNCTION get_incremental_date()
        RETURNS DATE  
        AS (
            DATE('2020-01-01')
        );
    {% endif %}
{% endcall %}

SELECT *
FROM {{ source('raw', 'transactions') }}
WHERE transaction_date >= get_incremental_date()
```

3. Tạo session variable
```sql
{% call set_sql_header(config) %}
    {% if is_incremental() %}
        -- Tối ưu cho incremental: ít memory hơn
        SET @@session.max_sort_length = 1000;
        SET @@session.group_concat_max_len = 1000;
    {% else %}
        -- Full refresh: cần nhiều memory hơn
        SET @@session.max_sort_length = 10000;
        SET @@session.group_concat_max_len = 10000;
    {% endif %}
{% endcall %}
```