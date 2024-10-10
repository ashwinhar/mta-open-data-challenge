SELECT 
    complex_id						ada_complex_id
   ,LIST(DISTINCT stop_name)		stop_name_list
   ,LIST(line)						line_list
   ,FIRST(gtfs_latitude)            gtfs_latitude
   ,FIRST(gtfs_longitude)           gtfs_longitude
FROM {{ref("stg_stations")}}
WHERE ada = 1
GROUP BY complex_id
