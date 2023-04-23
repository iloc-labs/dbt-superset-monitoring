# Apache Superset monitoring dbt package ([Docs](https://iloc-labs.github.io/dbt-superset-monitoring))

The package transforms Apache Superset application database's core object tables into analytics-ready models.
 

> Tip: More details in the package's [dbt docs site](https://iloc-labs.github.io/dbt-superset-monitoring). 

| Model | Description |
| --- | --- |
| superset__charts | Each record represents a Superset chart, enriched with data about its creators, datasource types, and the number of dashboards where the chart used. |
| superset__dashboards | Each record represents a Superset dashboard, enriched with data about its creators and chart's count. |
| superset__tables |  Each record represents a Superset table, enriched with data about its creators and chart's count based on the current table. |
| superset__users | Each record represents a Superset user, enriched with data about the number of charts and dashboards created by user. |
| superset__dashboard_views | Each record represents a Superset dashboard view enriched with data about its viewer and dashboard creator. |
| superset__objects_list | Each record represents a Superset chart, dashboard, or table. |

#  Quickstart

## Step 1: Prerequisites

To use this dbt package, you must have the following:

- Self-hosted Superset with the production metastore on a separate host or container.
- Airbyte/Fivetran/Custom connector syncing data into your destination.
- BigQuery/PostgreSQL destination.

> Tip: Avoid exposing the production metastore database directly.

## Step 2: Install the package

Include the following package version in your `packages.yml` file:
```yaml
packages:
  - package: iloc-labs/dbt-superset-monitoring
    version: [">=0.1.0", "<0.9.0"]
```

## Step 3: Define database and schema variables
By default, the package runs using the target database and schema for sources. If this is not where your source data is, add the following configuration to your root `dbt_project.yml` file:
```yaml
# dbt_project.yml

vars:
  superset_source_database: your_database_name
  superset_source_schema: your_schema_name
```

## Step 4: Setting your timezone
To convert the timezone of all timestamps in the package, update the source zone (superset_source_tz) to your target zone (superset_target_tz) in [IANA tz Database format](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones):

```yaml
# dbt_project.yml

vars:
  superset_source_tz: "UTC"
  superset_target_tz: "America/New_York"
```

# Package dependencies
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package.

> If you have any of these dependent packages in your own packages.yml file, we highly recommend that you remove them from your root packages.yml to avoid package version conflicts.
```yaml
packages:
- package: calogica/dbt_date
  version: [">=0.7.0", "<0.8.0"]

- package: dbt-labs/dbt_utils
  version: [">=0.8.0", "<2.0.0"]
```

# Package Maintenance
I highly encourage and welcome contributions to this package.

# Example Usage
Simple example there.