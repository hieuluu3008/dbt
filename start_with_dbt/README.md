# 1. Introduction to DBT
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