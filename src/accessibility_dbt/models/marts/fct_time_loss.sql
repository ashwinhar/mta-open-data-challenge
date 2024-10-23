with
    -- Find total estimated ada ridership for each *existing* ada-compliant complex 
    ridership_per_destination_cte as (
        select
            destination_station_complex_id as existing_ada_complex_id,
            sum(re.estimated_ada_ridership) as estimated_ada_ridership
        from {{ ref("int_ridership_estimation") }} re
        group by re.destination_station_complex_id
    ),
    -- Find the total time loss for each relevant existing ada complex
    calculation_before_scalars_cte as (
        select
            rpd.existing_ada_complex_id,
            iac.stop_name_list as existing_ada_stop_names,
            tta.list_closest_planned_stations,
            rpd.estimated_ada_ridership,
            tta.avg_travel_time_diff,
            round(
                rpd.estimated_ada_ridership * tta.avg_travel_time_diff / 3600, 2
            ) as total_time_loss_hrs
        from ridership_per_destination_cte as rpd
        left join
            {{ ref("int_ada_complexes") }} as iac
            on rpd.existing_ada_complex_id = iac.ada_complex_id
        inner join
            {{ ref("int_travel_times_aggregated") }} as tta
            on tta.existing_ada_complex_id = rpd.existing_ada_complex_id
    )
select
    existing_ada_complex_id,
    list_extract(existing_ada_stop_names, 1) as existing_ada_complex_alias,
    len(list_closest_planned_stations) as num_planned_ada_stations,
    list_closest_planned_stations as planned_ada_stations,
    round(estimated_ada_ridership, 0) as estimated_ada_ridership,
    avg_travel_time_diff as avg_travel_time_diff_sec,
    {{ apply_multipliers("total_time_loss_hrs") }},
    total_time_loss_hrs as total_time_loss_hrs_100p
from calculation_before_scalars_cte as cbs
