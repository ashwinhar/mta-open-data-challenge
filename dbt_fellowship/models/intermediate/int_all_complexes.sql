SELECT 
    complex_id						ada_complex_id
   ,FIRST(gtfs_latitude)            gtfs_latitude
   ,FIRST(gtfs_longitude)           gtfs_longitude
FROM {{ref("stg_stations")}}
GROUP BY complex_id