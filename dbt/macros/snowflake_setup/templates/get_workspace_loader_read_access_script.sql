{% macro get_workspace_loader_read_access_script(project_name, loader_read_roles) %}

//=============================================================================
// create data resources
//=============================================================================
USE ROLE SECURITYADMIN;

{% for loader_read_role in loader_read_roles %} 
GRANT ROLE {{ loader_read_role }} TO ROLE {{ project_name }}_ADMIN;
GRANT ROLE {{ loader_read_role }} TO ROLE {{ project_name }}_DEVELOPER;
GRANT ROLE {{ loader_read_role }} TO ROLE {{ project_name }}_DBT_TEST_SERVICE_ACCOUNT_ROLE;
GRANT ROLE {{ loader_read_role }} TO ROLE {{ project_name }}_DBT_PROD_SERVICE_ACCOUNT_ROLE;

{% endfor %}

{% endmacro %}
