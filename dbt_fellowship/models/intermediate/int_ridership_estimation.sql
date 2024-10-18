{% set keys = [
    "origin_month",
    "origin_day_of_week",
    "origin_hour_of_day",
    "origin_station_complex_id",
] %}

with
    base as (
        select
            od.origin_station_complex_id,
            od.destination_station_complex_id,
            sum(
                hr.total_ada_ridership * od.proportion_from_origin
            ) as estimated_ada_ridership
        from {{ ref("int_origin_destination_ada") }} od
        left join
            {{ ref("int_hourly_ridership_aggregated") }} hr
            on {{ composite_key_join_conditions("hr", "od", keys) }}
        group by od.origin_station_complex_id, od.destination_station_complex_id
    )

select *
from base
