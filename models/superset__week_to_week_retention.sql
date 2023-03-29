with any_actions as (

    select distinct
        user_id,
        cast({{ dbt.date_trunc('week', 'log_timestamp') }} as date) as week
    from {{ ref('stg_superset__logs') }}

)
select
    any_actions.week,
    cast(
        count(distinct future_any_actions.user_id) 
        / count(distinct any_actions.user_id) as {{ dbt.type_float() }}
    ) as retention
from any_actions
left join any_actions as future_any_actions
    on any_actions.user_id = future_any_actions.user_id
    and any_actions.week = {{ dbt.dateadd('week', -1, 'future_any_actions.week') }}
group by any_actions.week