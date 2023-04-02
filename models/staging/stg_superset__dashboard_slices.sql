select
    id as dashboard_slice_id,
    dashboard_id,
    slice_id
from {{ source('superset', 'dashboard_slices') }}