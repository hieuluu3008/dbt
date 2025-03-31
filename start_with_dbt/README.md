# 1. Introduction to dbt
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

# 2. Set-up dbt
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
* Enter the password:
* Enter the role you have crate:
* Enter the warehouse you have crate:
* Enter the database you have crate:
* Enter the schema you have crate:
* Enter the threads: `number` ([Read threads for more information](definition/threads.md))
* Run `dbt debug` to validate the connection.
* Run `cd data_pipeline` to create a new folder for dbt project
* Run `code .` to access Visual Code Studio

# 3. Create & develop dbt
