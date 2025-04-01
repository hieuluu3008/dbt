# dbt_project.yml
The `dbt_project.yml` file is the main configuration file for a dbt project. It defines:
* **Project Name & Paths** – Where dbt should look for models, tests, snapshots, and more.
* **Database & Schema Settings** – How dbt organizes tables in your warehouse.
* **Materializations & Configs** – Default settings for models (tables, views, incremental).
* **Custom Variables & Metadata** – Store reusable settings for your project.
```yml
name: 'data_pipeline'
version: '1.0.0'

profile: 'data_pipeline' # This setting configures which "profile" dbt uses for this project.

# These configurations specify where dbt should look for different types of files.
# You probably won't need to change these!
model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

clean-targets:         # directories to be removed by `dbt clean`
  - "target"
  - "dbt_packages"

# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

models:
  data_pipeline:
    # Config indicated by + and applies to all files under models/example/
    staging:
      +materialized: view
      snowflake_warehouse: dbt_wh
    marts:
      +materialized: table
      snowflake_warehouse: dbt_wh
```
### Key Sections in `dbt_project.yml`
#### 1️⃣ Project Information
```yml
name: 'data_pipeline'
version: '1.0.0'
profile: 'data_pipeline'
```
Defines the **project name** and **which profile to use** for database connections.

#### 2️⃣ Model Configurations
You can set default materializations for different model folders.
```yml
models:
  data_pipeline:
    staging:
      +materialized: view
    marts:
      +materialized: table
```
This makes all models inside `staging/` views, `marts/` tables by default.

#### 3️⃣ Customizing Schema Names
You can assign custom schemas for different folders:
```yml
models:
  data_pipeline:
    staging:
      schema: staging
    marts:
      schema: production
```
Models in `staging/` will go into the `staging` schema, and models in `marts/` go into `production`.

#### 4️⃣ Custom Variables
You can define variables (`vars`) to store reusable values.
```yml
vars:
  country_filter: 'US'
```
And use them in a model:
```sql
SELECT * FROM customers WHERE country = '{{ var("country_filter") }}'
```
✔ This helps make queries dynamic and configurable.

#### 5️⃣ Enabling dbt_utils or Other Packages
If using dbt packages, declare them in `packages.yml` and reference them in `dbt_project.yml`:
```yml
models:
  my_dbt_project:
    staging:
      materialized: view
      +enabled: true  # Enable/disable models
    marts:
      materialized: table
      +tags: ['core', 'important']
```
✔ You can tag models for better organization.

