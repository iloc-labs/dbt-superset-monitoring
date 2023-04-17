select
    created_on,
    changed_on,
    id as table_id,
    table_name,
    main_dttm_col,
    default_endpoint,
    database_id,
    created_by_fk,
    changed_by_fk,
    "offset" as offset_,
    description,
    is_featured,
    cache_timeout,
    schema,
    sql,
    params,
    perm,
    filter_select_enabled,
    fetch_values_predicate,
    is_sqllab_view,
    template_params,
    schema_perm,
    extra,
    uuid,
    is_managed_externally,
    external_url
from {{ source('superset', 'tables') }}