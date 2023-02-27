select
    *,
    if (published, 'published', 'draft') as dashboard_status
from {{ source('superset', 'dashboards') }}