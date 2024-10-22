{% macro union_tables(table_name, columns_macro, num_tables) %}
    {% set unioned_query = [] %}

    {% for i in range(1, num_tables + 1) %}
        {% set source_name = (table_name) ~ i %}
        {% set query_part = (
            "SELECT "
            ~ columns_macro
            ~ " FROM "
            ~ source("mta", (source_name))
        ) %}
        {% do unioned_query.append(query_part) %}
    {% endfor %}

    {{ return(unioned_query | join(" UNION ALL ")) }}
{% endmacro %}
