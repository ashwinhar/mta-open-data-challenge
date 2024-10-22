{% macro hourly_ridership_columns() %}
    cast(transit_timestamp as timestamp) transit_timestamp,
    transit_mode transit_mode,
    station_complex_id origin_station_complex_id,
    station_complex origin_station_complex_name,
    payment_method payment_method,
    fare_class_category fare_class_category,
    cast(ridership as int) ridership,
    cast(transfers as int) transfers
{% endmacro %}

{% macro origin_destination_columns() %}
    cast(month as smallint) as origin_month,
    day_of_week as origin_day_of_week,
    cast(hour_of_day as smallint) as origin_hour_of_day,
    cast(timestamp as timestamp) as origin_timestamp,
    origin_station_complex_id as origin_station_complex_id,
    origin_station_complex_name as origin_station_complex_name,
    destination_station_complex_id as destination_station_complex_id,
    destination_station_complex_name as destination_station_complex_name,
    cast(estimated_average_ridership as numeric) as estimated_average_ridership
{% endmacro %}
