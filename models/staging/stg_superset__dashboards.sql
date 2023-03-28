select
    id as dashboard_id,
    created_on,
    changed_on,
    dashboard_titlevarchar,
    position_json,
    created_by_fk,
    changed_by_fk,
    css,
    description,
    slug,
    json_metadata,
    published,
    uuid,
    case when published then 'published' else 'draft' end as dashboard_status
from {{ source('superset', 'dashboards') }}