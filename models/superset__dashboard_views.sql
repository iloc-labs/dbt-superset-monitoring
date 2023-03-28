with dashboard_views as (

    select
        dashboard_id,
        count(log_id) as view_count,
        count(distinct user_id) as viewers_count
    from {{ ref('stg_superset__logs') }}
    where lower(action) = 'dashboardrestapi.get'
    group by 1

)
select
    views.dashboard_id,
    dashboards.dashboard_title,
    views.view_count,
    views.viewers_count
from dashboard_views views
left join {{ ref('stg_superset__dashboards') }} dashboards
    on views.dashboard_id = dashboards.dashboard_id
order by views.view_count desc
