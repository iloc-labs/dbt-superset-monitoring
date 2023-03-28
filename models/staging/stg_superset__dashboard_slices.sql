select
    id as dashboard_slice,
    dashboard_id,
    slice_id
from {{ source('superset', 'dashboard_slices') }}