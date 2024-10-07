{% docs int_hourly_ridership_timestamp_parts %}

Partitions the `transit_timestamp` column using DuckDB's `date_part` function
such that we can eventually achieve the same grain as `fct_origin_destination`

{% enddocs %}