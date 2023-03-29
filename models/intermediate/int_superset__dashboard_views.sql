select
    logs.dashboard_id,
    dashboards.dashboard_title,
    logs.user_id as viewer_id,
    user.user_name as viewer_name,
    cast({{ dbt.date_trunc('day', 'log_timestamp') }} as date) as view_date,
    dashboards.dashboard_status,
    dashboards.created_by_fk,
    user_cr.user_name as created_by,
    count(logs.log_id) view_count,
from {{ ref('stg_superset__logs') }} logs
left join {{ ref('stg_superset__dashboards') }} dashboards
    on logs.dashboard_id = dashboards.dashboard_id
left join {{ ref('stg_superset__ab_user') }} user
    on logs.user_id = user.user_id
left join {{ ref('stg_superset__ab_user') }} user_cr
    on dashboards.created_by_fk = user_cr.user_id
where lower(logs.action) = 'dashboardrestapi.get'
group by 1, 2, 3, 4, 5, 6, 7, 8