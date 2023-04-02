with charts_count_table as (

    select
        datasource_id as table_id,
        count(distinct slice_id) as charts_count
    from {{ ref('stg_superset__slices') }}
    where datasource_type = 'table'
    group by 1

)
select
    tables.table_id,
    tables.table_name,
    tables.created_on,
    tables.changed_on,
    tables.database_id,
    tables.created_by_fk,
    tables.changed_by_fk,
    tables.description,
    tables.filter_select_enabled,
    tables.is_sqllab_view,
    user_cr.user_name as created_by,
    user_ch.user_name as changed_by,
    coalesce(ch_count.charts_count, 0) as charts_count
from {{ ref('stg_superset__tables') }} tables
left join {{ ref('stg_superset__ab_user')}} user_cr
    on tables.created_by_fk = user_cr.user_id
left join {{ ref('stg_superset__ab_user')}} user_ch
    on tables.changed_by_fk = user_ch.user_id
left join charts_count_table as ch_count
    on tables.table_id = ch_count.table_id