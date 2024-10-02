SELECT
    CAST(month AS SMALLINT)                         origin_month
   ,day_of_week                                     origin_day_of_week
   ,CAST(hour_of_day AS SMALLINT)                   origin_hour_of_day
   ,CAST(timestamp AS TIMESTAMP)                    origin_timestamp
   ,origin_station_complex_id                       origin_station_complex_id
   ,origin_station_complex_name                     origin_station_complex_name
   ,destination_station_complex_id                  destination_station_complex_id
   ,destination_station_complex_name                destination_station_complex_name
   ,CAST(estimated_average_ridership AS NUMERIC)    estimated_average_ridership
FROM {{source ('mta', 'origin_destination_20230102')}}
