-- Test name: nearest_stations_quality_check
-- Description: Ensure that all complex_id and station_id values in the
-- manual_entry.nearest_stations table actually exist in the MTA dataset.
-- Severity: error
select *
from manual_entry.nearest_ada_stations nas
left join
    mta.stations s
    on nas.planned_ada_station_id = s.station_id
    and nas.planned_ada_complex_id = s.complex_id
where nas.planned_ada_complex_id is null or nas.planned_ada_station_id is null
