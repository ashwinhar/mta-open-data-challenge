{% docs int_hourly_ridership_timestamp_parts %}

Partitions the `transit_timestamp` column using DuckDB's `date_part` function
such that we can eventually achieve the same grain as `fct_origin_destination`

{% enddocs %}


{% docs int_ada_complexes %}

Filters to all complexes in `stg_stations` that have at least one record where `ada = 1`. 
Brings all lines in the complex and station names into a list. 

{% enddocs %}


{% docs int_origin_destination_ada %}

Filters origin and destination to all combinations where both `origin_station_complex_id` and
`destination_station_complex_id` are in `int_ada_complexes.ada_complex_id`. In other words,
filters the table to all records where both the origin and destination are accessible. Also
defines a ridership `proportion_from_origin`. See column-level documentation for more details.

{% enddocs %}


{% docs int_hourly_ridership_filteraggregate %}

Aggregates `hourly_ridership` into the same grain as `origin_destination` but instead of *averaging* the ridership it totals the ridership. This way, we don't lose information.

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