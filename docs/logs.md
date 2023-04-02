
## Action logs.

There are two source of action logs:
- server
    - superset core
    - superset api
- client

### Server logs.
[Github link](https://github.com/apache/superset/blob/master/superset/views/core.py)
### Superset core
| Action | Description |
| ------------- | ------------- |
| welcome | Personalized welcome page open|
| fave_slices | Favorite slices for a user |
| profile | User profile page |
| sqllab | SQL Editor open |
| sqllab_history | Query history open |
| dashboard | Server side rendering for a dashboard (Creates a new Dashboard)|
| ... | |

### Superset api
| Action | Description |
| ------------- | ------------- |
| [DashboardRestApi](https://github.com/apache/superset/blob/master/superset/dashboards/api.py) | |
| .get | Gets a dashboard |
| .get_datasets | Gets a dashboard's datasets |
| .delete | Deletes a Dashboard |
| .post| Creates a new Dashboard |
| .export | Export dashboards |
| .favorite_status | Favorite Stars for Dashboards
| .get_charts | Gets the chart definitions for a given dashboard |
| .put | Changes a Dashboard |
| [ChartRestApi](https://github.com/apache/superset/blob/master/superset/charts/api.py) |  |
| .post | Creates a new Chart |
| .put | Changes a Chart |
| .delete | Deletes a Chart |
| .favorite_status | Favorite stars for Charts |
| .export | Export charts |
| [DatasetRestApi](https://github.com/apache/superset/blob/master/superset/datasets/api.py)| |
| .post | Creates a new Dataset |
| .put | Changes a Dataset |
| .delete | Deletes a Dataset |
| .export | Export datasets |
| .duplicate | Duplicates a Dataset |
| .refresh | Refreshes and updates columns of a dataset |
| ... | |
| [SqlLabRestApi](https://github.com/apache/superset/blob/master/superset/sqllab/api.py) | |
| .get_results | Gets the result of a SQL query execution |
| .export_csv | Exports the SQL query results to a CSV |
| .execute_sql_query | Executes a SQL query |
| .estimate_query_cost | Estimates the SQL query execution cost |



### Client logs.
[Github link](https://github.com/apache/superset/blob/master/superset-frontend/src/logger/LogUtils.ts)

`action = 'log'`

| Event name | Description |
| ------------- | ------------- |
| load_chart | |
| render_chart | |
| hide_browser_tab | |
| mount_dashboard | |
| mount_explorer | |
| select_dashboard_tab | |
| force_refresh_chart | |
| change_explore_controls | |
| toggle_edit_dashboard | |
| force_refresh_dashboard | |
| periodic_render_dashboard | |
| explore_dashboard_chart | |
| export_csv_dashboard_chart | |
| change_dashboard_filter | | 
| dataset_creation_empty_cancellation | | 
| dataset_creation_database_cancellation | | 
| dataset_creation_schema_cancellation | | 
| dataset_creation_table_cancellation | |
| dataset_creation_success | |
| spa_navigation | |
| confirm_overwrite_dashboard_metadata | |
| dashboard_download_as_image | |
| chart_download_as_image | |
| sqllab_warn_local_storage_usage | |
| sqllab_fetch_failed_query | |


