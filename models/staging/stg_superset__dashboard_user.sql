select
    id as dashboard_user_id,
    user_id,
    dashboard_id
from {{ source('superset', 'dashboard_user') }}
