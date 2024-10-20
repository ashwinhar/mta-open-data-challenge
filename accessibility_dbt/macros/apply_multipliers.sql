{% macro apply_multipliers(column_name) %}
    {% set increments = range(10, 60, 10) %}
    {% for increment in increments %}
        round(
            {{ column_name }} * {{ increment / 100 }}, 2
        ) as {{ column_name }}_{{ increment }}p
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}
