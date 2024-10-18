select
    complex_id complex_id,
    first(gtfs_latitude) gtfs_latitude,
    first(gtfs_longitude) gtfs_longitude
from {{ ref("stg_stations") }}
group by complex_id
