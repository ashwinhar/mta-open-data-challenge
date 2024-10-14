SELECT 
	datepart('month', transit_timestamp)	      origin_month
   ,datepart('hour', transit_timestamp)		   origin_hour_of_day
   ,{{ get_day_of_week('transit_timestamp') }}  origin_day_of_week
   ,* exclude transit_timestamp
from {{ref('stg_hourly_ridership')}}