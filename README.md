Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


# Healthcare Analytics Warehousing Simulation

## Project Overview

An end-to-end healthcare analytics engineering project built with dbt Core and DuckDB. The project transforms synthetic patient, provider, encounter, and claims data into tested dimensional models and reporting marts.

## Business Objectives

- Standardize healthcare records from multiple source files.
- Detect and handle duplicate, missing, and invalid records.
- Build patient and provider dimensions and encounter and claims fact tables.
- Track monthly healthcare activity and provider performance.
- Analyze billed, paid, and outstanding claim amounts.
- Implement reusable data-quality tests and model documentation.

## Technology Stack

- **Transformation:** dbt Core
- **Warehouse:** DuckDB
- **Language:** SQL
- **Development:** VS Code, Python, Git, GitHub

## Data Architecture

1. Seeds — synthetic source CSV files.
2. Staging — standardized data types and column formats.
3. Intermediate — deduplication and validation.
4. Dimensions and facts — analytics-ready dimensional warehouse.
5. Reporting — monthly healthcare KPIs, provider performance, and claims financials.

## Key Models

- `dim_patient`
- `dim_provider`
- `fct_encounter`
- `fct_claim`
- `fct_patient_monthly_activity`
- `rpt_monthly_healthcare_kpis`
- `rpt_provider_performance`
- `rpt_claims_financials`

## Run Locally

Install Python and Git, then install dbt Core with the DuckDB adapter in a virtual environment.

```bash
pip install dbt-core dbt-duckdb
dbt debug
dbt seed
dbt build
dbt docs generate
dbt docs serve
```

Configure the `healthcare_analytics_dbt` profile in your local `~/.dbt/profiles.yml` before running dbt commands.

## Data Quality

The project includes tests for unique identifiers, required fields, relationships between fact and dimension tables, and financial validity. Source defects are handled through cleaning models and validation rules.

## Disclaimer

This project uses synthetic data for educational and portfolio purposes only. It does not contain real patient records and is not intended for clinical decision-making.
