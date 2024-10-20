select
    complex_id as ada_complex_id,
    list(distinct stop_name) as stop_name_list,
    list(line) as line_list,
    first(gtfs_latitude) as gtfs_latitude,
    first(gtfs_longitude) as gtfs_longitude
from {{ ref("stg_stations") }}
where ada = 1
group by complex_id
