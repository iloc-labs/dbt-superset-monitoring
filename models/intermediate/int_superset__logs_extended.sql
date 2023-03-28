select
    cast({{ dbt.date_trunc('day','logs.log_timestamp') }} as date) log_date,
    logs.action,
    logs.user_id,
    logs.dashboard_id,
    logs.slice_id,
    ab_user.user_name,
    ab_user.user_registration_date,
    dashboards.dashboard_title,
    dashboards.dashboard_status,
    slices.slice_name,
    slices.datasource_type,
    slices.datasource_name,
    slices.datasource_id
from {{ ref('stg_superset__logs') }} logs
left join {{ ref('stg_superset__ab_user') }} ab_user
    on ab_user.user_id = logs.user_id
left join {{ ref('stg_superset__dashboards') }} dashboards
    on dashboards.id = logs.dashboard_id
left join {{ ref('stg_superset__dashboard_slices') }} slices
    on slices.id = logs.slice_id
where logs.action != 'log'