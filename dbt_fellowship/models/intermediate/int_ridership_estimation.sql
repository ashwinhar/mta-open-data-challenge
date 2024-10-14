{% set keys = ['origin_month', 'origin_day_of_week', 'origin_hour_of_day', 'origin_station_complex_id'] %}

WITH base AS (
    SELECT
        od.*,
        hr.total_ada_ridership*od.proportion_from_origin    estimated_ada_ridership
    FROM {{ref("int_origin_destination_ada")}}                  od
    LEFT JOIN {{ref("int_hourly_ridership_filteraggregate")}}   hr
    ON {{ composite_key_join_conditions('hr', 'od', keys) }}
)

SELECT * from base