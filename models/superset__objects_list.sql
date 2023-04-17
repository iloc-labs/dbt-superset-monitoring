with objects as (

    select
        table_name as name,
        'virtualized dataset' as source,
        'published' as status,
        created_by_fk,
        changed_by_fk,
        created_on,
        changed_on
    from {{ ref('stg_superset__tables') }}
    where cast(is_sqllab_view as {{ dbt.type_boolean() }}) = true
    
    union all
    
    select
        dashboard_title as name,
        'dashboard' as source,
        dashboard_status as status,
        created_by_fk,
        changed_by_fk,
        created_on,
        changed_on
    from {{ ref('stg_superset__dashboards') }}
    
    union all
    
    select
        slice_name as name,
        'chart' as source,
        'published' as status,
        created_by_fk,
        changed_by_fk,
        created_on,
        changed_on
    from {{ ref('stg_superset__slices') }}

), objects_with_properties as (

    select 
        objects.name,
        objects.source,
        user_cr.user_name as created_by,
        user_ch.user_name as changed_by,
        objects.status,
        objects.created_on,
        objects.changed_on,
        objects.name like '%untitled%' as to_rename
    from objects
    left join {{ ref('stg_superset__ab_user') }} user_cr
        on objects.created_by_fk = user_cr.user_id
    left join {{ ref('stg_superset__ab_user') }} user_ch
        on objects.changed_by_fk = user_ch.user_id

)
select *
from objects_with_properties