with joined_users as (

    select 
        cast({{ dbt.date_trunc('day', 'created_on') }} as date) date,
        count(slice_id) as chart_count
    from {{ ref('stg_superset__slices') }}
    group by 1

)
select
    date,
    sum(chart_count) over (
        order by date asc
        rows between unbounded preceding and current row
    ) as charts
from joined_users