{% docs int_ada_complexes %}
Filters to all complexes in `stg_stations` that have at least one record where `ada = 1`. 
Brings all lines in the complex and station names into a list. 

{% enddocs %}


{% docs complex_gtfs_latitude %}
The first latitude found from `stg_stations` for the given `complex_id`. We therefore assume that all stations within a certain complex are reasonably close enough together where we can pick any latitude and it doesn't matter. 

{% enddocs %}


{% docs complex_gtfs_longitude %}
The first longitude found from `stg_stations` for the given `complex_id`. We therefore assume that all stations within a certain complex are reasonably close enough together where we can pick any longitude and it doesn't matter. 

{% enddocs %}


{% docs int_all_complexes %}
Extracts all unique `complex_id` values with any (latitude,longitude) pair found in `stg_stations`

{% enddocs %}

{% docs int_origin_destination_ada %}

Filters origin and destination to all combinations where both `origin_station_complex_id` and
`destination_station_complex_id` are in `int_ada_complexes.ada_complex_id`. In other words,
filters the table to all records where both the origin and destination are accessible. Also
defines a ridership `proportion_from_origin`. See column-level documentation for more details.

{% enddocs %}


{% docs int_hourly_ridership_aggregated %}
Partitions the `transit_timestamp` column using DuckDB's `date_part` function such that we can eventually achieve the same grain as `fct_origin_destination`. Aggregates `hourly_ridership` into the same grain as `origin_destination` but instead of *averaging* the ridership it totals the ridership. Also, filters to only records where `fare_class_category` is either 'Metrocard - Seniors & Disability' or 'OMNY - Seniors & Disability'

{% enddocs %}


{% docs total_ada_ridership %}
Sum of `ridership` from `stg_hourly_ridership`

{% enddocs %}

{% docs proportion_from_origin %}

Calculates the proportion of riders to the destination given a single composite key of
(`origin_month`, `origin_day_of_week`, `origin_hour_of_day`, `origin_station_complex_id`). 
Specifically, let's say for that composite key we summed `estimated_average_ridership` and
got a column called `total_estimated_average_ridership`, which equaled 100. For example, we
had 100 riders begin their subway journeys at Union Square on January, Mondays, at midnight. 

Then, we divide each destination by that number to get a *proportion* of riders for that
destination and composite key. For example, if 20 of the riders above traveled to Grand
Central, the `proportion_from_origin` would be 0.2 (20%). 

{% enddocs %}


{% docs int_ridership_estimation %}
Multiplies the proportion of riders to an estimation (see previous table in lineage for more documentation) by the total ADA riders. Note that the previous two tables are joined on the key (`origin_month`, `origin_day_of_week`, `origin_hour_of_day`,`origin_station_complex_id`). Then, we find the total estimated ridership for a particular (origin, destination) pair across the entire time context.

{% enddocs %}


{% docs int_travel_times_aggregated %}
In this model we are trying to find the average time loss from every *existing* ADA-accessible complex to all corresponding planned ADA complexes. For example, let's take 96 St. station (`complex_id = 310`). It is currently ADA-accessible, and would be the closest complex for the mobility-impaired to use if they want to get to either Central Park North (110 St)/Lenox or 125 St/Lenox. Using some toy data, we might see something like this: 

| `existing_ada_complex` | `planned_ada_complex` | `walking_time_sec` | `train_time_sec` |
|------------------------|-----------------------|--------------------|------------------|
| 96 St.                 | Central Park North (110 St)/Lenox  | 2000  | 1000             | 
| 96 St.                 | 125 St/Lenox          | 1000               | 500              | 

Mobility-impaired people definitionally walk slower than the average. In a [NIMH study](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5992037/), the walking speed is 20%-50% slower. Splitting the difference, we scale `walking_time_sec` up by 35%, take the difference with `train_time_sec`, and then average for each complex. Thus, we would get the following equation for the first record above:

2000\*1.35 - 1000 = 1700

In other words, from 96 St., it takes on average 1275 sec to get to planned ADA complexes. Ideally, we would use a weighted average based on real data in `mta.origin_destination`. For right now, we assume an even split. 

{% enddocs %}

{% docs list_closest_planned_stations %}
All corresponding `planned_ada_station_name` values corresponding to the `existing_ada_complex_id` based on `stg_travel_times`.

{% enddocs %}

{% docs avg_travel_time_diff%}
The average of the `travel_time_diff` (sec), where `travel_time_diff` is the difference between `walking_time_sec` and `train_time_sec`. 

{% enddocs%}