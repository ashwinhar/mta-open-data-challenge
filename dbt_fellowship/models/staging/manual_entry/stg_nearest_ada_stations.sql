SELECT 
    CAST(mta_sort_order AS SMALLINT)                    mta_sort_order
   ,planned_ada_complex_id                              planned_ada_complex_id
   ,planned_ada_station_id                              planned_ada_station_id
   ,planned_ada_station_name                            planned_ada_station_name
   ,northbound_nearest_complex_id                       northbound_nearest_complex_id
   ,northbound_nearest_stop_name                        northbound_nearest_stop_name
   ,southbound_nearest_complex_id                       southbound_nearest_complex_id
   ,southbound_nearest_stop_name                        southbound_nearest_stop_name
FROM {{source('manual_entry', 'nearest_ada_stations')}}