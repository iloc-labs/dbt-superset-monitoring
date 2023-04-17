select
    logs.dashboard_id,
    dashboards.dashboard_title,
    logs.user_id as viewer_id,
    user_vw.user_name as viewer_name,
    log_timestamp as view_timestamp,
    dashboards.dashboard_status,
    user_cr.user_name as created_by
from {{ ref('stg_superset__logs') }} logs
left join {{ ref('stg_superset__dashboards') }} dashboards
    on logs.dashboard_id = dashboards.dashboard_id
left join {{ ref('stg_superset__ab_user') }} user_vw
    on logs.user_id = user_vw.user_id
left join {{ ref('stg_superset__ab_user') }} user_cr
    on dashboards.created_by_fk = user_cr.user_id
where lower(logs.action) = 'dashboardrestapi.get'