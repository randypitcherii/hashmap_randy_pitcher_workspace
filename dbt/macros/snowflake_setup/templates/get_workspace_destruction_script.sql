{% macro get_workspace_destruction_script(project_name) %}

//=============================================================================
// delete top level system resources
//=============================================================================
USE ROLE SYSADMIN;

// Databases
DROP DATABASE IF EXISTS {{ project_name }}_DEV;
DROP DATABASE IF EXISTS {{ project_name }}_TEST;
DROP DATABASE IF EXISTS {{ project_name }}_PROD;

// warehouses
DROP WAREHOUSE IF EXISTS {{ project_name }}_DEV_WH;
DROP WAREHOUSE IF EXISTS {{ project_name }}_TEST_WH;
DROP WAREHOUSE IF EXISTS {{ project_name }}_PROD_WH;
//=============================================================================


//=============================================================================
// delete users and roles 
//=============================================================================
USE ROLE SECURITYADMIN;

// drop roles
DROP ROLE IF EXISTS {{ project_name }}_DEV_READ;
DROP ROLE IF EXISTS {{ project_name }}_DEV_WRITE;
DROP ROLE IF EXISTS {{ project_name }}_TEST_READ;
DROP ROLE IF EXISTS {{ project_name }}_TEST_WRITE;
DROP ROLE IF EXISTS {{ project_name }}_PROD_READ;
DROP ROLE IF EXISTS {{ project_name }}_PROD_WRITE;
DROP ROLE IF EXISTS {{ project_name }}_DEV_WH_ALL_PRIVILEGES;
DROP ROLE IF EXISTS {{ project_name }}_TEST_WH_USAGE;
DROP ROLE IF EXISTS {{ project_name }}_PROD_WH_USAGE;
DROP ROLE IF EXISTS {{ project_name }}_ADMIN;
DROP ROLE IF EXISTS {{ project_name }}_DEVELOPER;
DROP ROLE IF EXISTS {{ project_name }}_DBT_TEST_SERVICE_ACCOUNT_ROLE;
DROP ROLE IF EXISTS {{ project_name }}_DBT_PROD_SERVICE_ACCOUNT_ROLE;

// drop users
DROP USER IF EXISTS {{ project_name }}_DBT_TEST_SERVICE_ACCOUNT_USER;
DROP USER IF EXISTS {{ project_name }}_DBT_PROD_SERVICE_ACCOUNT_USER;

{% endmacro %}
