select
    gtfs_stop_id as gtfs_stop_id,
    station_id as station_id,
    complex_id as complex_id,
    line as line,
    stop_name as stop_name,
    borough as borough,
    cast(gtfs_latitude as numeric) as gtfs_latitude,
    cast(gtfs_longitude as numeric) as gtfs_longitude,
    cast(ada as tinyint) as ada,
    cast(ada_northbound as boolean) as ada_northbound,
    cast(ada_southbound as boolean) as ada_southbound
from {{ source("mta", "stations") }}
