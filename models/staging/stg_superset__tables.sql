select
    *
from {{ source('superset', 'tables') }}