# Jinja
Jinja is a templating language used in dbt to make SQL queries dynamic, reusable, and configurable. It allows you to:
* Use variables for dynamic queries.
* Loop and conditionally execute code.
* Call dbt functions like ref(), source(), and config().
* Use macros to create reusable SQL snippets.

### Basic Jinja syntax in dbt
|Syntax      | Purpose                    | Example                                           |
|------------|----------------------------|---------------------------------------------------|
|`{{ ... }}` | Outputs a value            | SELECT * FROM {{ ref('country') }}                |
|`{% ... %}` | Runs logic (if, for, ...)  | {% if var('region') == 'US' %} ... {% endif %}    |

#### 1️⃣ Using Variables in Jinja
You can define custom variables in `dbt_project.yml`:
```yml
vars:
  country: 'US'
```
And use it in a model:
```sql
SELECT * FROM customers WHERE country = '{{ var("country") }}'
```

#### 2️⃣ Conditional Logic (if/else)
Apply a filter only for a specific country
```sql
SELECT * FROM customers
{% if var("country") == "US" %}
WHERE country = 'US'
{% else %}
WHERE country IS NOT NULL
{% endif %}
```
✔ If `var("country")` is `"US"`, the query becomes:
```sql
SELECT * FROM customers WHERE country = 'US'
```
✔ If `var("country")` is something else, it becomes:
```sql
SELECT * FROM customers WHERE country IS NOT NULL
```
#### 3️⃣ Looping (for)
Generate a list of columns dynamically
```sql
SELECT 
{% for col in ['id', 'name', 'email'] %}
    {{ col }}{% if not loop.last %}, {% endif %}
{% endfor %}
FROM customers
```
✔ This expands to:
```sql
SELECT id, name, email FROM customers
```
#### 4️⃣ Using Macros (Reusable Functions)
A sql file in `macros/`folder:
```sql
{% macro calculate_discount(price, discount) %}
    ({{ price }} * (1 - {{ discount }}))
{% endmacro %}
```
Use it in a model
```sql
SELECT 
    order_id, 
    price, 
    {{ calculate_discount('price', '0.1') }} AS discounted_price
FROM orders
```
✔ This applies a 10% discount dynamically.
#### 5️⃣ Combining Jinja with dbt Functions
In dbt, `ref()` and `source()` are used to reference different types of tables in a SQL model.

| Function                            | Purpose                              | Use Case                                 |  
|-------------------------------------|--------------------------------------|------------------------------------------|
| ref('model_name')                   | Refers to a model inside project     | When referencing transformed dbt models  |
| source('source_name','table_name')  | Refers to an external source table   | When pull raw data from the database     |

1. `ref()` – Referencing dbt Models <br>
📌 Used to reference models that dbt has already built.
* Ensures dependencies are properly managed.
* dbt automatically resolves schema names.
* Allows dbt to control model execution order.
```sql
SELECT * FROM {{ ref('stg_customers') }}
```
This ensures that dbt pulls the latest version of stg_customers when running this query.

2. `source()` – Referencing Raw Data Sources <br>
📌 Used to reference raw tables that dbt does not manage.
* Helps document where data comes from (source tracking).
* Ensures dbt only reads approved source tables.
* Enables automated testing and monitoring. <br>
Define sources in `sources_file.yml`
```yml
sources:
  - name: raw_data
    schema: raw_schema
    tables:
      - name: customers
```
Use `source()` in a model
```sql
SELECT * FROM {{ source('raw_data', 'customers') }}
```
This queries `raw_schema.customers` while keeping the schema configurable.
