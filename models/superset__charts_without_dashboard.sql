select
    slices.slice_id as chart_id,
    slice_name as chart_name,
    viz_type,
    changed_on
from {{ ref('stg_superset__slices') }} slices
left join {{ ref('stg_superset__dashboard_slices') }} dashboard_slices
    on slices.slice_id = dashboard_slices.slice_id
where dashboard_slices.dashboard_id is null