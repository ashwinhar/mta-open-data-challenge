SELECT 
	datepart('month', transit_timestamp)	 transit_month
   ,datepart('hour', transit_timestamp)		 transit_hour_of_day
   ,CASE
        WHEN datepart('dayofweek', transit_timestamp) = 1 THEN 'Monday'
        WHEN datepart('dayofweek', transit_timestamp) = 2 THEN 'Tuesday'
        WHEN datepart('dayofweek', transit_timestamp) = 3 THEN 'Wednesday'
        WHEN datepart('dayofweek', transit_timestamp) = 4 THEN 'Thursday'
        WHEN datepart('dayofweek', transit_timestamp) = 5 THEN 'Friday'
        WHEN datepart('dayofweek', transit_timestamp) = 6 THEN 'Saturday'
        WHEN datepart('dayofweek', transit_timestamp) = 7 THEN 'Sunday'
    END AS transit_day_of_week,
    * exclude transit_timestamp
from {{ref('stg_hourly_ridership')}}