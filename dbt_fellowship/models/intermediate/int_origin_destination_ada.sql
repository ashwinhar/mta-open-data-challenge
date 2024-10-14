-- Simply filters the origin_destination table to just rides where both the origin and destination are accessible
WITH origin_destination_ada_CTE AS (
	SELECT 
		sod.*
	FROM {{ref("stg_origin_destination")}}	                            sod
	inner join	{{ref("int_ada_complexes")}}	                        iac_o
		on sod.origin_station_complex_id = iac_o.ada_complex_id
	inner join {{ref("int_ada_complexes")}}		                        iac_d
		on sod.destination_station_complex_id = iac_d.ada_complex_id
),
/*
 * This cte generates the total ridership for a particular month, day, hour, origin combo.
 * We can then use this number to find a "proportion" for each destination. That is to say,
 * if 100 riders on average departed from origin_staiton_complex_id = 622 on January, Monday,
 * at midnight. And if destination_id = 2 has 20 riders on average, then the total proportion
 * is 20%. Again, since we are summing averages, this number isn't "reliable" per se. It's just
 * the best we can do with the available data.
 */
total_ridership_CTE AS (
	SELECT 
		origin_month
	   ,origin_day_of_week
	   ,origin_hour_of_day
	   ,origin_station_complex_id
	   ,sum(estimated_average_ridership)	total_estimated_average_ridership	
	FROM origin_destination_ada_CTE
	GROUP BY
		origin_month
	   ,origin_day_of_week
	   ,origin_hour_of_day
	   ,origin_station_complex_id
)

SELECT
	od.*
	,estimated_average_ridership/tr.total_estimated_average_ridership	proportion_from_origin
FROM origin_destination_ada_CTE				od
LEFT JOIN total_ridership_CTE   			tr
	ON 	od.origin_month						 = tr.origin_month
	AND	od.origin_day_of_week			     = tr.origin_day_of_week
	AND	od.origin_hour_of_day				 = tr.origin_hour_of_day
	AND	od.origin_station_complex_id		 = tr.origin_station_complex_id
