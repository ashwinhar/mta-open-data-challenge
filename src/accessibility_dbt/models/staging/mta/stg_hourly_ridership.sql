select {{ origin_destination_columns() }} from {{ source("mta", "hourly_ridership") }}
