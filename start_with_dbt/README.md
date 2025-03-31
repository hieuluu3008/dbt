# 1. Introduction to DBT
### Definition
dbt - data build tool, is designed to simplify the management of data warehouses and transform the data within(ELT - ETL processes). It allows for easy transition between data warehouse types, such as Snowflake, BigQuery, Postgres. dbt also provides the ability to use SQL across teams of multiple users, simplifying interaction. In addition, dbt translates between SQL dialects as appropriate to connect to different data sources and warehouses.

### Features
1. SQL-Based Data Transformation:
    dbt allows you to write modular SQL code to define transformations.
    Each SQL file represents a model that dbt compiles and runs inside your data warehouse.

2. Dependency Management & DAG Structure
    automatically create a DAG of transformations to ensure the models run in the correct order based on dependencies

3. 
