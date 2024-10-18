with
    cte as (
        select
            datepart('month', transit_timestamp) as origin_month,
            datepart('hour', transit_timestamp) as origin_hour_of_day,
            {{ get_day_of_week("transit_timestamp") }} as origin_day_of_week,
            * exclude transit_timestamp
        from {{ ref("stg_hourly_ridership") }}
    )

select
    origin_month,
    origin_day_of_week,
    origin_hour_of_day,
    origin_station_complex_id,
    sum(ridership) as total_ada_ridership
from cte
where
    fare_class_category
    in ('Metrocard - Seniors & Disability', 'OMNY - Seniors & Disability')
group by origin_month, origin_day_of_week, origin_hour_of_day, origin_station_complex_id
