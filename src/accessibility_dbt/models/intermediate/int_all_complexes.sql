select
    complex_id as complex_id,
    first(gtfs_latitude) as gtfs_latitude,
    first(gtfs_longitude) as gtfs_longitude
from {{ ref("stg_stations") }}
group by complex_id
