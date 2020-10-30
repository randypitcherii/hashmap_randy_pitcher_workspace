{% macro destroy_full_snowflake_project(project_name) %}

  {% set destruction_script %}
    {{ get_workspace_destruction_script(project_name) }}
  {% endset %}
   
  {% do log(destruction_script, True) %}
  {% do run_query(destruction_script) %}
{% endmacro %}