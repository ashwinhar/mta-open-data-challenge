{% macro composite_key_join(table_1, table_2, keys) %}
    {{ table_1 }} 
    JOIN {{ table_2 }}
    ON
    {%- for key in keys %}
        {{ table_1 }}.{{ key }} = {{ table_2 }}.{{ key }}
        {%- if not loop.last %} AND {% endif %}
    {%- endfor %}
{% endmacro %}

{% macro composite_key_group_by(keys) %}
    GROUP BY
    {%- for key in keys %}
        {{ key }}
        {%- if not loop.last %}, {% endif %}
    {%- endfor %}
{% endmacro %}

{% macro composite_key_join_conditions(table_1, table_2, keys) %}
    {%- for key in keys %}
        {{ table_1 }}.{{ key }} = {{ table_2 }}.{{ key }}
        {%- if not loop.last %} AND {% endif %}
    {%- endfor %}
{% endmacro %}