select
    id as log_id,
    user_id,
    json,
    dashboard_id,
    slice_id,
    duration_ms,
    duration_ms/1000 as duration_sc,
    referrer,
    case 
        when lower(action) = 'queries' then 'sqllab query'
        when lower(action) = 'chartrestapi.data' then 'charts query'
        when lower(action) = 'count' then 'dashboard view'
        when lower(action) like 'annotation%' then 'annotations'
        when lower(action) like 'css%' then 'css'
        else lower(action)
    end as action_type,
    action,
    {{ dbt_date.convert_timezone(
        column='cast(dttm as ' ~ dbt.type_timestamp() ~ ')',
        target_tz=var('superset_target_tz', "UTC"),
        source_tz=var('superset_source_tz', "UTC"))
    }} as log_timestamp
from {{ source('superset', 'logs') }}