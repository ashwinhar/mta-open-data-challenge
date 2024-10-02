SELECT 
    CAST(transit_timestamp AS TIMESTAMP)     transit_timestamp
   ,transit_mode                        transit_mode
   ,station_complex_id                  station_complex_id
   ,station_complex                     station_complex
   ,payment_method                      payment_method
   ,fare_class_category                 fare_class_category
   ,ridership                           original_ridership
   ,CAST(ridership AS INT)              ridership
   ,CAST(transfers AS INT)              transfers
FROM {{source ('mta', 'hourly_ridership_20230102' )}}