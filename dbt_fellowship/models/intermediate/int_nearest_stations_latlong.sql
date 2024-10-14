with northbound_CTE as (
	SELECT 
		northbound_nearest_complex_id as existing_ada_complex_id,
		northbound_nearest_stop_name  as existing_ada_stop_name,
		*
	exclude (
		northbound_nearest_complex_id, 
		northbound_nearest_stop_name,
		southbound_nearest_stop_name,
		southbound_nearest_complex_id)
	FROM {{ref("stg_nearest_ada_stations")}}
),

southbound_CTE as (
	SELECT
		southbound_nearest_complex_id as existing_ada_complex_id,
		southbound_nearest_stop_name  as existing_ada_stop_name,
		*
	exclude (
		northbound_nearest_complex_id,
		northbound_nearest_stop_name,
		southbound_nearest_stop_name,
		southbound_nearest_complex_id)
	FROM {{ref("stg_nearest_ada_stations")}}
),

unioned_CTE as (
select * from northbound_CTE
UNION ALL
select * from southbound_CTE
)

SELECT
	mta_sort_order
   ,planned_ada_complex_id
   ,planned_ada_station_name
   ,IAC_PLANNED.gtfs_latitude	            planned_ada_complex_latitude
   ,IAC_PLANNED.gtfs_longitude	            planned_ada_complex_longitude
   ,existing_ada_complex_id         
   ,existing_ada_stop_name          
   ,IAC_Existing.gtfs_latitude	            existing_ada_complex_latitude
   ,IAC_Existing.gtfs_longitude             existing_ada_complex_longitude
FROM unioned_CTE				            U
LEFT JOIN {{ref("int_all_complexes")}}		IAC_Planned
	ON IAC_Planned.ada_complex_id = U.planned_ada_complex_id
LEFT JOIN {{ref("int_all_complexes")}}		IAC_Existing
	ON IAC_EXISTING.ada_complex_id = U.existing_ada_complex_id