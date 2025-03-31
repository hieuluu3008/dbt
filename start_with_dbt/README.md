# I. Introduction to dbt
### Definition
dbt - data build tool, is designed to simplify the management of data warehouses and transform the data within(ELT - ETL processes). It allows for easy transition between data warehouse types, such as Snowflake, BigQuery, Postgres. dbt also provides the ability to use SQL across teams of multiple users, simplifying interaction. In addition, dbt translates between SQL dialects as appropriate to connect to different data sources and warehouses.

### Features
#### 1. SQL-Based Data Transformation:
write modular SQL code to define transformations. <br>
organize data into tables, views, other database objects, and defines the relationships between them <br>
Each SQL file represents a model that dbt compiles and runs inside the data warehouse.

##### 2. Dependency Management & DAG Structure:
automatically create a DAG of transformations to ensure the models run in the correct order based on dependencies

#### 3. Data Testing & Quality Control
test the data models using built-in and custom tests.

#### 4. Incremental Models
supports incremental models, which process only new or changed data instead of reprocessing everything to improve performance and reduces processing costs.

#### 5. Code Reusability (Jinja & Macros)
supports Jinja templating to write reusable macros (similar to functions in SQL).

#### 6. Documentation & Data Lineage
automatically generates documentation for all models, including data lineage.

#### 7. Version Control & CI/CD Integration
integrates with Git for version control, allowing teams to collaborate. <br>
supports CI/CD pipelines, ensuring changes are tested before deployment.

#### 8.Compatibility with Multiple Data Warehouses
works with major cloud data warehouses: Snowflake, BigQuery, Postgres, Databricks, ...

# II. Set-up dbt
### Install
Run the following commands to install dbt:

```bash
pip install dbt-core
pip install dbt-snowflake ##when you work with Snowflake
pip install dbt-postgres ##when you work with Postgres
```
### Set-up Snowflake (when you work with snowflake)
Visit the link: https://www.snowflake.com/en/ and create an new account (if you have not) <br>
*How to create an Snowflake account: https://www.youtube.com/watch?v=VIJH7TZXkaA&t=434s* <br>
Menu --> Projects --> Worksheets --> Create SQL Worksheet <br>
and run the following code by step:
```sql
use role accountadmin;

create warehouse dbt_wh with warehouse_size='x-small';
create database if not exists dbt_db;
create role if not exists dbt_role;

show grants on warehouse dbt_wh;

grant usage on warehouse dbt_wh to role dbt_role;
grant role dbt_role to user 'input_user_name';
grant all on database dbt_db to role dbt_role;

use role dbt_role;

create schema dbt_db.dbt_schema;

use role accountadmin;

drop warehouse if exists dbt_wh;
drop database if exists dbt_db;
drop role if exists dbt_role;
```
This will create a new schema for objects in dbt project

### Run dbt
Following the step:
* Open the cmd
* Run `dbt init` 
* Enter project name: 
* Select database to use: (snowflake)
* Enter user account: input account_identifier <br>
from Menu --> Admin --> Accounts --> Locator `https://<account_identifier>.snowflakecomputing.com`
* Select the authen option (password=1):
* Enter the user password:
* Enter the role you have crate:
* Enter the warehouse you have crate:
* Enter the database you have crate:
* Enter the schema you have crate:
* Enter the threads: `number` ([Read threads for more information](definition/threads.md))
* Run `dbt debug` to validate the connection.
* Run `cd data_pipeline` to create a new folder for dbt project
* Run `code .` to access Visual Code Studio

# III. dbt Features
### Models
a SQL file that defines a transformation in your data warehouse. When you run dbt, it compiles these models into SQL queries and executes them to create views or tables. <br>
Ex:
```sql
select
    o_orderkey as orderkey,
    o_custkey as customer_key,
    o_orderstatus as status_code,
    o_totalprice as total_price,
    o_orderdate as order_date
from
    {{ source('tpch','orders')}}
```
#### How to run a dbt model?
```bash
dbt run
```
Or when run a certain model
```bash
dbt run -select model_sql_file
```
or
```bash
dbt run -s model_sql_file
```
#### Configuration in dbt Model:
Control how models are built by [materialized](definition/materialized.md)

### Seed
a CSV file can be loaded into a data warehouse by `dbt seed` command. This is useful for:
* Loading reference/static data (e.g., country codes, product categories).
* Creating small lookup tables (e.g., user roles, mappings).
* Simplifying development/testing with sample datasets.

#### How it work?
Place a CSV files inside `seeds/`folder and run `dbt seed` command to load these CSVs into the database. <br>
* When need to update or re-seed data
```bash
dbt seed --full-refresh
```

### Analyses
store ad-hoc SQL queries reports, or exploratory analysis that are not intended to be materialized (i.e., they do not create tables or views in the database).<br>
Usage:
* Store one-off analytical queries that don’t fit as dbt models.
* Share SQL reports with team members for review.
* Use dbt macros and Jinja to write dynamic and reusable queries.
* Organize queries for business insights, debugging, or testing.

#### How it work?
Create a .sql file inside `analyses/`folder to store queries and run `dbt compile`

### Tests
a SQL file that automates data quality checks in dbt project to ensure models are accruate and reliable. These tests validate data integrity, consistency, and business logic before models are used in production.

#### Type of dbt Tests
1. Generic Tests (Built-in, easy to use)
can be add directly in model `.yml` file
```yml
models:
  - name: dim_customers
    columns:
      - name: customer_id
        tests:
          - unique ## no duplicate value
          - not_null ## no missing value
```
2. Singular Tests (Advanced, in tests/ folder)
a SQL file located inside `tests/`folder <br>
Ex:
```sql
SELECT * 
FROM {{ ref('fct_sales') }}
WHERE total_revenue < 0  -- Revenue should never be negative
```
If this query returns rows, the test fails ❌.

#### How it work?
You can test all models:
```bash
dbt test
```
Or test a specific model:
```bash
dbt test --select test_sql_file
```
