WITH cte AS (
SELECT 
	datepart('month', transit_timestamp)	         origin_month
   ,datepart('hour', transit_timestamp)		      origin_hour_of_day
   ,{{ get_day_of_week('transit_timestamp') }}     origin_day_of_week
   ,* exclude transit_timestamp
from {{ref('stg_hourly_ridership')}}
)

SELECT 
    origin_month
   ,origin_day_of_week
   ,origin_hour_of_day
   ,origin_station_complex_id
   ,sum(ridership)			    total_ada_ridership
FROM cte 
WHERE 
	fare_class_category IN ('Metrocard - Seniors & Disability', 'OMNY - Seniors & Disability')
GROUP BY
    origin_month
   ,origin_day_of_week
   ,origin_hour_of_day
   ,origin_station_complex_id