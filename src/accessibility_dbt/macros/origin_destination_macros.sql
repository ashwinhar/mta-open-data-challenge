{% macro origin_destination_columns() %}
    cast(transit_timestamp as timestamp) transit_timestamp,
    transit_mode transit_mode,
    station_complex_id origin_station_complex_id,
    station_complex origin_station_complex_name,
    payment_method payment_method,
    fare_class_category fare_class_category,
    cast(ridership as int) ridership,
    cast(transfers as int) transfers
{% endmacro %}
