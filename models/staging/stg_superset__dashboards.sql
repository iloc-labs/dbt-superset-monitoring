select
    *,
    case when published then 'published' else 'draft' end as dashboard_status
from {{ source('superset', 'dashboards') }}