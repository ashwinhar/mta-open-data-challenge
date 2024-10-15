select
    gtfs_stop_id                        gtfs_stop_id
   ,CAST(station_id AS NUMERIC)         station_id
   ,complex_id                          complex_id
   ,line                                line
   ,stop_name                           stop_name
   ,borough                             borough
   ,CAST(gtfs_latitude AS NUMERIC)      gtfs_latitude
   ,CAST(gtfs_longitude AS NUMERIC)     gtfs_longitude
   ,CAST(ada AS TINYINT)                ada
   ,CAST(ada_northbound AS BOOLEAN)     ada_northbound
   ,CAST(ada_southbound AS BOOLEAN)     ada_southbound
from {{ source('mta','stations')}}