WITH cte AS (
SELECT * FROM {{ref('int_hourly_ridership_timestamp_parts')}}
)
SELECT 
	transit_month
   ,transit_hour_of_day
   ,transit_day_of_week
   ,station_complex_id
   ,avg(ridership)			average_disability_ridership
FROM cte 
WHERE 
	fare_class_category IN ('Metrocard - Seniors & Disability', 'OMNY - Seniors & Disability')
GROUP BY
	transit_month
   ,transit_hour_of_day
   ,transit_day_of_week
   ,station_complex_id