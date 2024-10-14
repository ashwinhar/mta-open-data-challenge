{% macro get_day_of_week(timestamp) %}
    -- This macro returns the name of the day (Monday, Tuesday, etc.)
    -- based on the 'dayofweek' extracted from the given timestamp.

    CASE
        WHEN datepart('dayofweek', {{ timestamp }}) = 1 THEN 'Monday'
        WHEN datepart('dayofweek', {{ timestamp }}) = 2 THEN 'Tuesday'
        WHEN datepart('dayofweek', {{ timestamp }}) = 3 THEN 'Wednesday'
        WHEN datepart('dayofweek', {{ timestamp }}) = 4 THEN 'Thursday'
        WHEN datepart('dayofweek', {{ timestamp }}) = 5 THEN 'Friday'
        WHEN datepart('dayofweek', {{ timestamp }}) = 6 THEN 'Saturday'
        WHEN datepart('dayofweek', {{ timestamp }}) = 7 THEN 'Sunday'
    END
{% endmacro %}