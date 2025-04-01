# essential dbt commands
1. Project Initialization & Setup
* `dbt init <project_name>` → Initialize a new dbt project.
* `dbt debug` → Check if the project is correctly set up (e.g., database connection).

2. Running Models
* `dbt run` → Execute all models in the project.
* `dbt run --select <model_name>` → Run a specific model.
* `dbt run --select <folder_name>/*` → Run all models in a specific folder.
* `dbt run --exclude <model_name>` → Run all models except the specified one.

3. Testing & Validation
* `dbt test` → Run all tests defined in the project (e.g., uniqueness, not null).

* `dbt test --select <model_name>` → Test a specific model.

4. Documentation & Analysis
* `dbt docs generate` → Generate documentation for models, sources, and tests.
* `dbt docs serve` → Start a local web server to view the documentation.

5. Compiling & Debugging
* `dbt compile` → Compile dbt models into raw SQL queries (without executing them).
* `dbt debug` → Check project and connection status.

6. Source Freshness Checks
* `dbt source freshness` → Check the freshness of source tables.

7. Deployment & Environments
* `dbt build` → Runs **models, tests, snapshots, and seeds** in one command.
* `dbt seed` → Load CSV files from the data/ directory into the database.
* `dbt snapshot` → Capture and track changes in source data over time.

8. Advanced Filtering & Selection
* `dbt run --select +<model_name>` → Run a model and all its downstream dependencies.
* `dbt run --select <model_name>+` → Run a model and all its upstream dependencies.
* `dbt run --select <model_A> <model_B>` → Run multiple models at once.
* `dbt run --defer --state <path>` → Use artifacts from a previous run to optimize execution.

9. Cleaning & Maintenance
* `dbt clean` → Remove temporary files and compiled artifacts.
* `dbt deps` → Install dependencies defined in packages.yml.
