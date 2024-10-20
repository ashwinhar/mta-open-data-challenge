select
    cast(mta_sort_order as smallint) as mta_sort_order,
    planned_ada_complex_id as planned_ada_complex_id,
    planned_ada_station_name as planned_ada_station_name,
    cast(planned_ada_complex_latitude as numeric) as planned_ada_complex_latitude,
    cast(planned_ada_complex_longitude as numeric) as planned_ada_complex_longitude,
    existing_ada_complex_id as existing_ada_complex_id,
    existing_ada_stop_name as existing_ada_stop_name,
    cast(existing_ada_complex_latitude as numeric) as existing_ada_complex_latitude,
    cast(existing_ada_complex_longitude as numeric) as existing_ada_complex_longitude,
    cast(walking_time_sec as numeric) as walking_time_sec,
    cast(train_time_sec as numeric) as train_time_sec
from {{ source("manual_entry", "travel_times") }}
