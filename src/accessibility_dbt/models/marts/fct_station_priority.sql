with
    cte as (
        select
            unnest(planned_ada_stations) planned_ada_station,
            total_time_gain_hrs_2p / num_planned_ada_stations as adjusted_time_gain_2p,
            total_time_gain_hrs_4p / num_planned_ada_stations as adjusted_time_gain_4p,
            total_time_gain_hrs_6p / num_planned_ada_stations as adjusted_time_gain_6p,
            total_time_gain_hrs_8p / num_planned_ada_stations as adjusted_time_gain_8p,
            total_time_gain_hrs_10p / num_planned_ada_stations as adjusted_time_gain_10p
        from {{ ref("fct_time_gain") }}
    )
select
    planned_ada_station,
    round(sum(adjusted_time_gain_2p), 2) as total_time_gain_2p,
    round(sum(adjusted_time_gain_4p), 2) as total_time_gain_4p,
    round(sum(adjusted_time_gain_6p), 2) as total_time_gain_6p,
    round(sum(adjusted_time_gain_8p), 2) as total_time_gain_8p,
    round(sum(adjusted_time_gain_10p), 2) as total_time_gain_10p,
from cte
group by 1
order by 2 desc
