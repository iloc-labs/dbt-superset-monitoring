select
    dashboards.dashboard_id,
    dashboards.dashboard_title,
    dashboards.dashboard_status,
    user_cr.user_name as created_by,
    dashboards.created_on,
    user_ch.user_name as changed_by,
    dashboards.changed_on
from {{ ref('stg_superset__dashboards') }} dashboards
left join {{ ref('stg_superset__ab_user') }} user_cr
    on dashboards.created_by_fk = user_cr.user_id
left join {{ ref('stg_superset__ab_user') }} user_ch
    on dashboards.changed_by_fk = user_ch.user_id
order by created_on