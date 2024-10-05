SELECT 
    CAST(mta_sort_order AS SMALLINT)                    mta_sort_order
   ,CAST(planned_ada_complex_id AS NUMERIC)             planned_ada_complex_id
   ,CAST(planned_ada_station_id AS NUMERIC)             planned_ada_station_id
   ,planned_ada_station_name                            planned_ada_station_name
   ,CAST(northbound_nearest_complex_id AS NUMERIC)      northbound_nearest_complex_id
   ,northbound_nearest_station_name                     northbound_nearest_station_name
   ,CAST(southbound_nearest_complex_id AS NUMERIC)      southbound_nearest_complex_id
   ,southbound_nearest_station_name                     southbound_nearest_station_name
FROM {{source('manual_entry', 'nearest_ada_stations')}}