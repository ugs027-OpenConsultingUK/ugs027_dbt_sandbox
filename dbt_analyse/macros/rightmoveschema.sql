{% macro generate_schema_name(custom_schema_name, node) -%}
    {# 
      Forces the schema based on model names.
    #}

    {% if node.name == 'rightmove_listings_silver' %}
        {{ 'RIGHTMOVE' }}
    {% elif node.name == 'otm_silver' %}
        {{ 'OTM' }}
    {% elif node.name == 'zooplasftp' %}
        {{ 'ZOOPLA' }}
    {% else %}
        {# 
           This is for the final model 'alllistings'. 
           It should return the schema defined in the model's config ('MASTER').
           This is why custom_schema_name is CRITICAL here.
        #}
        {{ custom_schema_name | default(target.schema) }}
    {% endif %}

{%- endmacro %}