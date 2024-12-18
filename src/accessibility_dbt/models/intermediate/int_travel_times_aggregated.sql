-- In this model we want to get the difference in train time and walking time from one
-- origin to all destinations, and
-- then average that number to get the average time loss. Then we inner join on
-- exisitng_ada_complex_id to the final
-- intermediate table, and then aggregate in some way. 
-- Walking time for the mobility-impaired will be slower, and based on research (see
-- README) can be around 35%.
{% set mobility_scale = 1.35 %}
with
    /*
    The TravelTime API returns multiple records for the same request sometimes,
    presumably due to the async thing. We randomly pick one record from each
    distinct combo
    */
    row_nums as (
        select
            *,
            row_number() over (
                partition by planned_ada_complex_id, existing_ada_complex_id
            ) as row_num
        from {{ ref("stg_travel_times") }}
    ),
    distinct_combos as (select * exclude row_num from row_nums where row_num = 1),
    time_diff_cte as (
        select
            walking_time_sec *{{ mobility_scale }} - train_time_sec as travel_time_diff,
            *
        from distinct_combos
        where existing_ada_complex_id is not null
    )

select
    existing_ada_complex_id,
    list(planned_ada_station_name) as list_closest_planned_stations,
    round(avg(travel_time_diff), 2) as avg_travel_time_diff
from time_diff_cte
group by existing_ada_complex_id
