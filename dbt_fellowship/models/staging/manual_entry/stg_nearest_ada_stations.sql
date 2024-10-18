select
    cast(mta_sort_order as smallint) as mta_sort_order,
    planned_ada_complex_id as planned_ada_complex_id,
    planned_ada_station_id as planned_ada_station_id,
    planned_ada_station_name as planned_ada_station_name,
    northbound_nearest_complex_id as northbound_nearest_complex_id,
    northbound_nearest_stop_name as northbound_nearest_stop_name,
    southbound_nearest_complex_id as southbound_nearest_complex_id,
    southbound_nearest_stop_name as southbound_nearest_stop_name
from {{ source("manual_entry", "nearest_ada_stations") }}
