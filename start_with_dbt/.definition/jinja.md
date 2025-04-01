# Jinja
Jinja is a templating language used in dbt to make SQL queries dynamic, reusable, and configurable. It allows you to:
* Use variables for dynamic queries.
* Loop and conditionally execute code.
* Call dbt functions like ref(), source(), and config().
* Use macros to create reusable SQL snippets.

### Basic Jinja syntax in dbt
|Syntax    | Purpose                    | Example                                           |
|----------|----------------------------|---------------------------------------------------|
|{{ ... }} | Outputs a value            | SELECT * FROM {{ ref('country') }}                |
|{% ... %} | Runs logic (if, for, ...)  | {% if var('region') == 'US' %} ... {% endif %}    |

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
✔ If var("country") is something else, it becomes:
```sql
SELECT * FROM customers WHERE country IS NOT NULL
```




