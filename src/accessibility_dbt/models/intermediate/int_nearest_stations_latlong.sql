with
    northbound_cte as (
        select
            northbound_nearest_complex_id as existing_ada_complex_id,
            northbound_nearest_stop_name as existing_ada_stop_name,
            * exclude (
                northbound_nearest_complex_id,
                northbound_nearest_stop_name,
                southbound_nearest_stop_name,
                southbound_nearest_complex_id
            )
        from {{ ref("stg_nearest_ada_stations") }}
    ),

    southbound_cte as (
        select
            southbound_nearest_complex_id as existing_ada_complex_id,
            southbound_nearest_stop_name as existing_ada_stop_name,
            * exclude (
                northbound_nearest_complex_id,
                northbound_nearest_stop_name,
                southbound_nearest_stop_name,
                southbound_nearest_complex_id
            )
        from {{ ref("stg_nearest_ada_stations") }}
    ),

    unioned_cte as (
        select *
        from northbound_cte
        union all
        select *
        from southbound_cte
    )

select
    mta_sort_order,
    planned_ada_complex_id,
    planned_ada_station_name,
    iac_planned.gtfs_latitude as planned_ada_complex_latitude,
    iac_planned.gtfs_longitude as planned_ada_complex_longitude,
    existing_ada_complex_id,
    existing_ada_stop_name,
    iac_existing.gtfs_latitude as existing_ada_complex_latitude,
    iac_existing.gtfs_longitude as existing_ada_complex_longitude
from unioned_cte u
left join
    {{ ref("int_all_complexes") }} iac_planned
    on iac_planned.complex_id = u.planned_ada_complex_id
left join
    {{ ref("int_all_complexes") }} iac_existing
    on iac_existing.complex_id = u.existing_ada_complex_id
