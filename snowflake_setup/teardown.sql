//=============================================================================
// delete everything in the project
//=============================================================================
USE ROLE SYSADMIN;
DROP DATABASE  RANDY_PITCHER_WORKSPACE_DEV;
DROP DATABASE  RANDY_PITCHER_WORKSPACE_TEST;
DROP DATABASE  RANDY_PITCHER_WORKSPACE_PROD;
DROP WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH;
DROP WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH;
DROP WAREHOUSE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH;
DROP WAREHOUSE RANDY_PITCHER_WORKSPACE_TABLEAU_ANALYST_WH;
DROP WAREHOUSE RANDY_PITCHER_WORKSPACE_DEVELOPER_WH;

USE ROLE SECURITYADMIN;
DROP ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE;
DROP ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;
DROP ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE;
DROP ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
DROP ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE;
DROP ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST;
DROP ROLE RANDY_PITCHER_WORKSPACE_DEV_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_DEV_WRITE;
DROP ROLE RANDY_PITCHER_WORKSPACE_DEV_READ;
DROP ROLE RANDY_PITCHER_WORKSPACE_TEST_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_TEST_WRITE;
DROP ROLE RANDY_PITCHER_WORKSPACE_TEST_READ;
DROP ROLE RANDY_PITCHER_WORKSPACE_PROD_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_PROD_WRITE;
DROP ROLE RANDY_PITCHER_WORKSPACE_PROD_READ;
DROP ROLE RANDY_PITCHER_WORKSPACE_PROD_ANALYTICS_READ;
DROP ROLE RANDY_PITCHER_WORKSPACE_DEVELOPER_WH_OWNER;
DROP ROLE RANDY_PITCHER_WORKSPACE_DEVELOPER_WH_ALL_PRIVILEGES;
DROP ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
DROP ROLE RANDY_PITCHER_WORKSPACE_DEVELOPER;
DROP USER RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER;
DROP USER RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER;
DROP USER RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER;
//=============================================================================