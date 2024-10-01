SELECT
    CAST(month AS DATE)         ridership_month
   ,transport                   transport
   ,borough                     borough
   ,category                    category
   ,CAST(journeys AS BIGINT)    journeys
FROM {{source ('mta','reduced_fare')}}
WHERE
    DATE_PART('year', CAST(month AS DATE)) = 2023
