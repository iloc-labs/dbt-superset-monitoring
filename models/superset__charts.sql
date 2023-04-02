with dashboards_count as (

    select
        slice_id,
        count(distinct dashboard_id) as dashboards_count
    from {{ ref('stg_superset__dashboard_slices') }}
    group by slice_id

), datasource as (

    select
        table_id as datasource_id,
        table_name as datasource_name,
        'table' as datasource_type
    from {{ ref('stg_superset__tables') }}

)
select
    slices.slice_id,
    slices.slice_name,
    slices.created_on,
    slices.changed_on,
    slices.datasource_type,
    coalesce(slices.datasource_name, datasource.datasource_name) as datasource_name,
    slices.datasource_id,
    slices.viz_type,
    slices.description,
    slices.last_saved_at,
    slices.last_saved_by_fk,
    user_cr.user_name as created_by,
    user_ch.user_name as changed_by,
    user_sv.user_name as last_saved_by,
    coalesce(sl_dashboards.dashboards_count, 0) as dashboards_count
from {{ ref('stg_superset__slices') }} slices
left join {{ ref('stg_superset__ab_user')}} user_cr
    on slices.created_by_fk = user_cr.user_id
left join {{ ref('stg_superset__ab_user')}} user_ch
    on slices.changed_by_fk = user_ch.user_id
left join {{ ref('stg_superset__ab_user')}} user_sv
    on slices.last_saved_by_fk = user_sv.user_id
left join dashboards_count sl_dashboards
    on slices.slice_id = sl_dashboards.slice_id
left join datasource
    on slices.datasource_id = datasource.datasource_id
   and slices.datasource_type = datasource.datasource_type