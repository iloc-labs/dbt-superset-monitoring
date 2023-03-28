select
    id as user_id,
    first_name,
    last_name,
    username as user_name,
    password,
    active,
    email,
    login_count,
    fail_login_count,
    created_by_fk,
    changed_by_fk,
    {{ dbt_date.convert_timezone(
        column='cast(created_on as ' ~ dbt.type_timestamp() ~ ')',
        target_tz=var('superset_target_tz', "UTC"),
        source_tz=var('superset_source_tz', "UTC"))
    }} as user_registration_date,
    {{ dbt_date.convert_timezone(
        column='cast(changed_on as ' ~ dbt_utils.type_timestamp() ~ ')',
        target_tz=var('superset_target_tz', "UTC"),
        source_tz=var('superset_source_tz', "UTC"))
    }} as changed_on,
    {{ dbt_date.convert_timezone(
        column='cast(last_login as ' ~ dbt.type_timestamp() ~ ')',
        target_tz=var('superset_target_tz', "UTC"),
        source_tz=var('superset_source_tz', "UTC"))
    }} as user_last_login,
    {{ dbt.concat(["first_name", " ", "last_name"]) }} as full_name
from {{ source('superset', 'ab_user') }}