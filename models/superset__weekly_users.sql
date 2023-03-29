select
    cast({{ dbt.date_trunc('week','log_timestamp') }} as date) as week,
    count(distinct user_id) as active_users
from {{ ref('stg_superset__logs') }}
group by 1
order by 1 asc