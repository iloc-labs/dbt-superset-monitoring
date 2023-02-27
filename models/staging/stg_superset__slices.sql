select
    *
from {{ source('superset', 'slices') }}