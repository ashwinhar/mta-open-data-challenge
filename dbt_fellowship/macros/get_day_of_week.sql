{% macro get_day_of_week(timestamp) %}
    -- This macro returns the name of the day (Monday, Tuesday, etc.)
    -- based on the 'dayofweek' extracted from the given timestamp.
    case
        when datepart('dayofweek', {{ timestamp }}) = 1
        then 'Monday'
        when datepart('dayofweek', {{ timestamp }}) = 2
        then 'Tuesday'
        when datepart('dayofweek', {{ timestamp }}) = 3
        then 'Wednesday'
        when datepart('dayofweek', {{ timestamp }}) = 4
        then 'Thursday'
        when datepart('dayofweek', {{ timestamp }}) = 5
        then 'Friday'
        when datepart('dayofweek', {{ timestamp }}) = 6
        then 'Saturday'
        when datepart('dayofweek', {{ timestamp }}) = 7
        then 'Sunday'
    end
{% endmacro %}
