select
    CAST(mta_sort_order AS SMALLINT)                mta_sort_order
   ,planned_ada_complex_id                          planned_ada_complex_id
   ,planned_ada_station_name                        planned_ada_station_name
   ,CAST(planned_ada_complex_latitude AS NUMERIC)   planned_ada_complex_latitude
   ,CAST(planned_ada_complex_longitude AS NUMERIC)  planned_ada_complex_longitude
   ,existing_ada_complex_id                         existing_ada_complex_id
   ,existing_ada_stop_name                          existing_ada_stop_name
   ,CAST(existing_ada_complex_latitude AS NUMERIC)  existing_ada_complex_latitude
   ,CAST(existing_ada_complex_longitude AS NUMERIC) existing_ada_complex_longitude
   ,CAST(walking_time_sec AS NUMERIC)               walking_time_sec
   ,CAST(train_time_sec AS NUMERIC)                 train_time_sec
from {{source('manual_entry', 'travel_times')}}