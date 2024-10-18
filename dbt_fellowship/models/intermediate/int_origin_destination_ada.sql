-- Simply filters the origin_destination table to just rides where both the origin and
-- destination are accessible
with
    origin_destination_ada_cte as (
        select sod.*
        from {{ ref("stg_origin_destination") }} sod
        inner join
            {{ ref("int_ada_complexes") }} iac_o
            on sod.origin_station_complex_id = iac_o.ada_complex_id
        inner join
            {{ ref("int_ada_complexes") }} iac_d
            on sod.destination_station_complex_id = iac_d.ada_complex_id
    ),
    /*
 * This cte generates the total ridership for a particular month, day, hour, origin combo.
 * We can then use this number to find a "proportion" for each destination. That is to say,
 * if 100 riders on average departed from origin_staiton_complex_id = 622 on January, Monday,
 * at midnight. And if destination_id = 2 has 20 riders on average, then the total proportion
 * is 20%. Again, since we are summing averages, this number isn't "reliable" per se. It's just
 * the best we can do with the available data.
 */
    total_ridership_cte as (
        select
            origin_month,
            origin_day_of_week,
            origin_hour_of_day,
            origin_station_complex_id,
            sum(estimated_average_ridership) as total_estimated_average_ridership
        from origin_destination_ada_cte
        group by
            origin_month,
            origin_day_of_week,
            origin_hour_of_day,
            origin_station_complex_id
    )

select
    od.*,
    estimated_average_ridership
    / tr.total_estimated_average_ridership as proportion_from_origin
from origin_destination_ada_cte od
left join
    total_ridership_cte tr
    on od.origin_month = tr.origin_month
    and od.origin_day_of_week = tr.origin_day_of_week
    and od.origin_hour_of_day = tr.origin_hour_of_day
    and od.origin_station_complex_id = tr.origin_station_complex_id
