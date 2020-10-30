{% macro grant_loader_read_to_snowflake_project(project_name, loader_read_roles) %}

  {% set grant_script %}
    {{ get_workspace_loader_read_access_script(project_name, loader_read_roles) }}
  {% endset %}
   
  {% do log(grant_script, True) %}
  {% do run_query(grant_script) %}
{% endmacro %}