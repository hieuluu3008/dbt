# Threads
threads define the number of parallel database connections that dbt can use when running models. <br>
control number of queries can run in the same time. <br>
More threads allow dbt to execute multiple queries simultaneously, improving performance.
### Where to find?
threads is specified in the dbt profile file (profiles.yml), typically found in: <br>
Windows: %USERPROFILE%\.dbt\profiles.yml <br>
Mac/Linux: ~/.dbt/profiles.yml
### How Threads Affect Performance
* More threads → Faster execution (up to the limit your database can handle).
* Too many threads → Potentially slower execution due to resource contention.<br>

**Optimal Thread Settings:**  

| Database   | Recommended Threads               |
|------------|------------------------------------|
| PostgreSQL | 4-8                               |
| Snowflake  | 4-10 (depends on warehouse size)  |
| BigQuery   | 8-16                              |
| Redshift   | 4-8                               |

