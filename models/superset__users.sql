with dashboards as (

    select
        created_by_fk,
        count(distinct dashboard_id) as dashboards_count
    from {{ ref('stg_superset__dashboards') }}
    group by created_by_fk

), charts as (

    select 
        created_by_fk,
        count(distinct slice_id) as charts_count
    from {{ ref('stg_superset__slices') }}
    group by created_by_fk

)
select 
    user_id,
    user_name,
    active,
    created_on,
    changed_on,
    last_login,
    coalesce(dashboards.dashboards_count, 0) as dashboards_count,
    coalesce(charts.charts_count, 0) as charts_count
from {{ ref('stg_superset__ab_user') }} user
left join dashboards on user.user_id = dashboards.created_by_fk
left join charts on user.user_id = charts.created_by_fk