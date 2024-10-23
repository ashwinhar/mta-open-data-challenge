{% macro apply_multipliers(column_name) %}
    {% set increments = range(2, 12, 2) %}
    {% for increment in increments %}
        round(
            {{ column_name }} * {{ increment / 100 }}, 2
        ) as {{ column_name }}_{{ increment }}p
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}
