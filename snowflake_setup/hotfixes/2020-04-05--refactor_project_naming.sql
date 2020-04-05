//=============================================================================
// rename everything in the project
//=============================================================================
USE ROLE SYSADMIN;
ALTER DATABASE  CICD_DEMO_DEV                RENAME TO RANDY_PITCHER_WORKSPACE_DEV;
ALTER DATABASE  CICD_DEMO_TEST               RENAME TO RANDY_PITCHER_WORKSPACE_TEST;
ALTER DATABASE  CICD_DEMO_PROD               RENAME TO RANDY_PITCHER_WORKSPACE_PROD;
ALTER WAREHOUSE CICD_DEMO_DBT_TEST_WH        RENAME TO RANDY_PITCHER_WORKSPACE_DBT_TEST_WH;
ALTER WAREHOUSE CICD_DEMO_DBT_PROD_WH        RENAME TO RANDY_PITCHER_WORKSPACE_DBT_PROD_WH;
ALTER WAREHOUSE CICD_DEMO_SIGMA_ANALYST_WH   RENAME TO RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH;
ALTER WAREHOUSE CICD_DEMO_TABLEAU_ANALYST_WH RENAME TO RANDY_PITCHER_WORKSPACE_TABLEAU_ANALYST_WH;
ALTER WAREHOUSE CICD_DEMO_DEVELOPER_WH       RENAME TO RANDY_PITCHER_WORKSPACE_DEVELOPER_WH;

USE ROLE SYSADMIN;
ALTER WAREHOUSE RANDY_PITCHER_WORKSPACE_DEVELOPER_WH SET
  COMMENT='Warehouse for powering data engineering activities for the RANDY_PITCHER_WORKSPACE project';
ALTER WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH SET
  COMMENT='Warehouse for powering CI test activities for the RANDY_PITCHER_WORKSPACE project';
ALTER WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH SET
  COMMENT='Warehouse for powering CI production activities for the RANDY_PITCHER_WORKSPACE project';
ALTER WAREHOUSE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH SET
  COMMENT='Warehouse for powering analytics queries from Sigma for the RANDY_PITCHER_WORKSPACE project';


USE ROLE SECURITYADMIN;
ALTER ROLE CICD_DEMO_DBT_TEST_WH_OWNER                    RENAME TO RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_OWNER;
ALTER ROLE CICD_DEMO_DBT_TEST_WH_USAGE                    RENAME TO RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE;
ALTER ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE        RENAME TO RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;
ALTER ROLE CICD_DEMO_DBT_PROD_WH_OWNER                    RENAME TO RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_OWNER;
ALTER ROLE CICD_DEMO_DBT_PROD_WH_USAGE                    RENAME TO RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE;
ALTER ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE        RENAME TO RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
ALTER ROLE CICD_DEMO_SIGMA_ANALYST_WH_OWNER               RENAME TO RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_OWNER;
ALTER ROLE CICD_DEMO_SIGMA_ANALYST_WH_USAGE               RENAME TO RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE;
ALTER ROLE CICD_DEMO_SIGMA_ANALYST                        RENAME TO RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST;
ALTER ROLE CICD_DEMO_TABLEAU_ANALYST_WH_OWNER             RENAME TO RANDY_PITCHER_WORKSPACE_TABLEAU_ANALYST_WH_OWNER;
ALTER ROLE CICD_DEMO_TABLEAU_ANALYST_WH_USAGE             RENAME TO RANDY_PITCHER_WORKSPACE_TABLEAU_ANALYST_WH_USAGE;
ALTER ROLE CICD_DEMO_TABLEAU_ANALYST                      RENAME TO RANDY_PITCHER_WORKSPACE_TABLEAU_ANALYST;
ALTER ROLE CICD_DEMO_DEV_OWNER                            RENAME TO RANDY_PITCHER_WORKSPACE_DEV_OWNER;
ALTER ROLE CICD_DEMO_DEV_WRITE                            RENAME TO RANDY_PITCHER_WORKSPACE_DEV_WRITE;
ALTER ROLE CICD_DEMO_DEV_READ                             RENAME TO RANDY_PITCHER_WORKSPACE_DEV_READ;
ALTER ROLE CICD_DEMO_TEST_OWNER                           RENAME TO RANDY_PITCHER_WORKSPACE_TEST_OWNER;
ALTER ROLE CICD_DEMO_TEST_WRITE                           RENAME TO RANDY_PITCHER_WORKSPACE_TEST_WRITE;
ALTER ROLE CICD_DEMO_TEST_READ                            RENAME TO RANDY_PITCHER_WORKSPACE_TEST_READ;
ALTER ROLE CICD_DEMO_PROD_OWNER                           RENAME TO RANDY_PITCHER_WORKSPACE_PROD_OWNER;
ALTER ROLE CICD_DEMO_PROD_WRITE                           RENAME TO RANDY_PITCHER_WORKSPACE_PROD_WRITE;
ALTER ROLE CICD_DEMO_PROD_READ                            RENAME TO RANDY_PITCHER_WORKSPACE_PROD_READ;
ALTER ROLE CICD_DEMO_PROD_ANALYTICS_READ                  RENAME TO RANDY_PITCHER_WORKSPACE_PROD_ANALYTICS_READ;
ALTER ROLE CICD_DEMO_DEVELOPER_WH_OWNER                   RENAME TO RANDY_PITCHER_WORKSPACE_DEVELOPER_WH_OWNER;
ALTER ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES          RENAME TO RANDY_PITCHER_WORKSPACE_DEVELOPER_WH_ALL_PRIVILEGES;
ALTER ROLE CICD_DEMO_ADMIN                                RENAME TO RANDY_PITCHER_WORKSPACE_ADMIN;
ALTER ROLE CICD_DEMO_DEVELOPER                            RENAME TO RANDY_PITCHER_WORKSPACE_DEVELOPER;
ALTER USER CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_USER        RENAME TO RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER;
ALTER USER CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_USER        RENAME TO RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER;
ALTER USER CICD_DEMO_SIGMA_ANALYST_SERVICE_ACCOUNT_USER   RENAME TO RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER;

USE ROLE SECURITYADMIN;
ALTER USER RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER SET
  COMMENT = 'Service account for DBT CI in the test (TEST) environment of the RANDY_PITCHER_WORKSPACE project.'
  DEFAULT_ROLE=RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE
  DEFAULT_WAREHOUSE=RANDY_PITCHER_WORKSPACE_DBT_TEST_WH
  DISPLAY_NAME=RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER
  LOGIN_NAME=RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER;
ALTER USER RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER SET
  COMMENT = 'Service account for DBT CI in the production (PROD) environment of the RANDY_PITCHER_WORKSPACE project.'
  DEFAULT_ROLE=RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE
  DEFAULT_WAREHOUSE=RANDY_PITCHER_WORKSPACE_DBT_PROD_WH
  DISPLAY_NAME=RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER
  LOGIN_NAME=RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER;
ALTER USER RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER SET
  COMMENT = 'Service account for connecting Sigma to Snowflake for RANDY_PITCHER_WORKSPACE analytics.'
  DEFAULT_ROLE=RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST
  DEFAULT_WAREHOUSE=RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH
  DISPLAY_NAME=RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER
  LOGIN_NAME=RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER;
//=============================================================================