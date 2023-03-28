with cte_names as (
    
    select
        table_name as name,
        'virtualized dataset' as source,
        'published' as status,
        created_by_fk as created_by_user_id
    from tables
    where 1=1 and is_sqllab_view = true
 
    union 
    
    select
        dashboard_title as name,
        'dashboard' as source,
        dashboard_status as status,
        created_by_fk as created_by_user_id
    from dashboards
        
    union
    
    select
        slice_name as name,
        'charts' as source,
        'published' as status,
        created_by_fk as created_by_user_id
    from slices

),
cte_names_with_properties as (

    select 
        name,
        source,
        u.username as owner,
        status,
        lower(split_part(name,'.', 1)) = split_part(name,'.', 1) as domain_is_lowercase,
        lower(name) like '%.%' as has_dot,
        lower(name) like 'archived%' as is_archived,
        lower(name) like '%untitled%' or lower(name) ~ '\d{2}\/\d{2}\/\d{4}' as has_bad_phrases
    from cte_names as tmp
    left join ab_user as u on tmp.created_by_user_id = u.id
)
select 
    *,
    if (domain_is_lowercase and has_dot and not has_bad_phrases and not is_archived, true, false) as is_valid
from cte_names_with_properties