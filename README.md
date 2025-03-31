# dbt Project

This repository contains a dbt (data build tool) project designed to transform raw data into structured models for analytics and business intelligence.

## Project Structure

The project adheres to the standard dbt project layout:

- **models/**: Contains SQL files that define the transformation logic.
- **seeds/**: Includes CSV files with static data that can be loaded into your data warehouse.
- **snapshots/**: Stores snapshot files to capture the state of mutable tables over time.
- **macros/**: Holds reusable SQL snippets to DRY (Don't Repeat Yourself) up your codebase.
- **tests/**: Contains tests to ensure data quality and model integrity.
- **analyses/**: Stores ad-hoc SQL queries or analyses that aren't part of the main transformation pipeline.

For a detailed explanation of each component, refer to the [dbt project documentation](https://docs.getdbt.com/docs/build/projects).

## Getting Started

To set up and run this dbt project locally, follow these steps:

1. **Install dbt**: Ensure you have dbt installed on your system. You can install it using pip:

   ```bash
   pip install dbt
