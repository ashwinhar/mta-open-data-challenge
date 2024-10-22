{% docs composite_key_group %}
I have a long composite key built of `origin_month`, `origin_day_of_week`, `origin_hour_of_day`, and `origin_station_complex_id`. This is a helper function that condenses the `GROUP BY` statement.

{% enddocs %}

{% docs composite_key_join %}
I have a long composite key built of `origin_month`, `origin_day_of_week`, `origin_hour_of_day`, and `origin_station_complex_id`. This is a helper function that condenses the conditions for the `JOIN` statement given two tables.

{% enddocs %}

{% docs apply_multipliers %}
Applies a scalar multiplier to all values in a column, and then adds a prefix for the scalar to the column increments of 0.1, from 0.1 to 0.5. For example, each value in a column called `rides` is multiplied by 10%, and then the column name would be `rides_10p`

{% enddocs %}

{% docs hourly_ridership_columns %}
All the monthly `mta.hourly_ridership_x` tables are unioned together, and it's annoying to write out the columns and transformations every time. This macro templates it. 

{% enddocs %}

{% docs origin_destination_columns %}
All the monthly `mta.origin_destination_x` tables are unioned together, and it's annoying to write out the columns and transformations every time. This macro templates it. 

{% enddocs %}

{% docs union_tables %}
Two of the important tables in this project require a long `UNION` statement of 12 separate tables (one for each month). This macro expresses that `UNION`. 

{% enddocs %}