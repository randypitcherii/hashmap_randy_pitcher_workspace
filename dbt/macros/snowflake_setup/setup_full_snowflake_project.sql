{% macro setup_full_snowflake_project(project_name, test_svc_accnt_password, prod_svc_accnt_password) %}

  {% set setup_script %}
    {{ get_workspace_setup_script(project_name, test_svc_accnt_password, prod_svc_accnt_password) }}
  {% endset %}
   
  {% do log(setup_script, True) %}
  {% do run_query(setup_script) %}
{% endmacro %}