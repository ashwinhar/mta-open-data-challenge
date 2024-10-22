{% macro composite_key_join_conditions(table_1, table_2, keys) %}
    {%- for key in keys %}
        {{ table_1 }}.{{ key }} = {{ table_2 }}.{{ key }}
        {%- if not loop.last %} and {% endif %}
    {%- endfor %}
{% endmacro %}
