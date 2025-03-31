# Profile
The `profiles.yml` file in dbt stores database connection settings. It tells dbt which database, schema, and credentials to use when running models.
* Manages Connection Configurations – Supports multiple environments (dev, prod).
* Keeps Credentials Secure – Stored separately from project files.
* Supports Multiple Databases – Works with Snowflake, BigQuery, Redshift, Postgres, etc.
### How to find?
The profiles.yml file is usually found in the ~/.dbt/ (home directory) on your machine:<br>
📂 Mac/Linux: `~/.dbt/profiles.yml` <br>
📂 Windows: `%USERPROFILE%\.dbt\profiles.yml` <br>
If the file doesn't exist, you can create it manually.<br>
Snowflake Example
```yml
my_dbt_project:
  outputs:
    dev:
      type: snowflake
      account: my_snowflake_account
      user: my_username
      password: my_password
      role: my_role
      database: my_database
      warehouse: my_warehouse
      schema: dbt_dev
      threads: 4
  target: dev
```
Postgres Example
```yml
my_project:
  outputs:
    dev:
      type: postgres
      host: my-database-host
      user: my_username
      password: my_password
      port: 5432
      dbname: analytics
      schema: dbt_dev
      threads: 4
  target: dev
```

### Switching between Env
To switch environments (e.g., from `dev` to `prod`), update:
```yml
my_project:
  target: prod
```
or override it when running dbt:
```bash
dbt run --target prod
```
