select
    *
from {{ source('superset', 'dashboard_slices') }}