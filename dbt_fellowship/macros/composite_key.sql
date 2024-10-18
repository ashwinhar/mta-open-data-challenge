{% macro composite_key_join(table_1, table_2, keys) %}
    {{ table_1 }}
    join
        {{ table_2 }}
        on {%- for key in keys %}
            {{ table_1 }}.{{ key }} = {{ table_2 }}.{{ key }}
            {%- if not loop.last %} and {% endif %}
        {%- endfor %}
{% endmacro %}

{% macro composite_key_group_by(keys) %}
    group by
        {%- for key in keys %}
            {{ key }} {%- if not loop.last %}, {% endif %}
        {%- endfor %}
{% endmacro %}

{% macro composite_key_join_conditions(table_1, table_2, keys) %}
    {%- for key in keys %}
        {{ table_1 }}.{{ key }} = {{ table_2 }}.{{ key }}
        {%- if not loop.last %} and {% endif %}
    {%- endfor %}
{% endmacro %}
