with
    granular_cte as (
        select
            destination_station_complex_id as existing_ada_complex_id,
            -- Multiplying the estimated amount of ada rides per the corresponding
            -- "travel time difference" between a train ride and walking. Dividing by
            -- 3600 converts from seconds to hours
            round(
                (sum(re.estimated_ada_ridership * tta.avg_travel_time_diff)) / 3600, 2
            ) as total_time_loss_hrs
        from {{ ref("int_ridership_estimation") }} re
        inner join
            {{ ref("int_travel_times_aggregated") }} tta
            on re.destination_station_complex_id = tta.existing_ada_complex_id
        group by re.destination_station_complex_id
    )
select
    gc.existing_ada_complex_id,
    iac.stop_name_list as existing_ada_stop_names,
    tta.list_closest_planned_stations,
    -- Apply estimation multipliers (assume 10% of rides had different intended
    -- destination, 20%, etc)
    {{ apply_multipliers("total_time_loss_hrs") }}
from granular_cte as gc
left join
    {{ ref("int_ada_complexes") }} as iac
    on gc.existing_ada_complex_id = iac.ada_complex_id
left join
    {{ ref("int_travel_times_aggregated") }} as tta
    on gc.existing_ada_complex_id = tta.existing_ada_complex_id
order by gc.existing_ada_complex_id asc
