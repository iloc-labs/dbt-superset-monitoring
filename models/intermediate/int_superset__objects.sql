with objects as (

    select
        table_name as name,
        'virtualized dataset' as source,
        'published' as status,
        created_by_fk as created_by_user_id
    from `dbt-iloc.superset.stg_superset__tables`
    -- where 1=1 and is_sqllab_view = true
    
    union all
    
    select
        dashboard_title as name,
        'dashboard' as source,
        dashboard_status as status,
        created_by_fk as created_by_user_id
    from `dbt-iloc.superset.stg_superset__dashboards`
    
    union all
    
    select
        slice_name as name,
        'chart' as source,
        'published' as status,
        created_by_fk as created_by_user_id
    from `dbt-iloc.superset.stg_superset__slices`

), objects_with_properties as (

    select 
        name,
        source,
        user.user_name as owner,
        status
    from objects
    left join `dbt-iloc.superset.stg_superset__ab_user` user
        on objects.created_by_user_id = user.user_id

)
select *
from objects_with_properties