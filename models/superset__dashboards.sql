with slices_count as (

    select
        dashboard_id,
        count(distinct slice_id) as charts_count
    from {{ ref('stg_superset__dashboard_slices') }}
    group by dashboard_id

)
select
    dashboards.dashboard_id,
    dashboards.created_on,
    dashboards.changed_on,
    dashboards.dashboard_title,
    dashboards.description,
    dashboards.published,
    dashboards.dashboard_status,
    user_cr.user_name as created_by,
    user_ch.user_name as changed_by,
    sl_dashboards.charts_count
from {{ ref('stg_superset__dashboards') }} dashboards
left join {{ ref('stg_superset__ab_user')}} user_cr
    on dashboards.created_by_fk = user_cr.user_id
left join {{ ref('stg_superset__ab_user')}} user_ch
    on dashboards.changed_by_fk = user_ch.user_id
left join slices_count sl_dashboards
    on dashboards.dashboard_id = sl_dashboards.dashboard_id
