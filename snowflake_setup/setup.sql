//=============================================================================
// create data resources
//=============================================================================
USE ROLE SYSADMIN;

// Databases
CREATE DATABASE CICD_DEMO_DEV;
CREATE DATABASE CICD_DEMO_TEST;
CREATE DATABASE CICD_DEMO_PROD;

// schemas
CREATE SCHEMA CICD_DEMO_PROD.ANALYTICS;
//=============================================================================


//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// dev warehouse
CREATE WAREHOUSE CICD_DEMO_DEVELOPER_WH
  COMMENT='Warehouse for powering data engineering activities for the CI/CD Demo project'
  WAREHOUSE_SIZE=XSMALL
  AUTO_SUSPEND=60
  INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access (OA) roles
//=============================================================================
USE ROLE SECURITYADMIN;

// data access
CREATE ROLE CICD_DEMO_DEV_OWNER;
CREATE ROLE CICD_DEMO_DEV_WRITE;
CREATE ROLE CICD_DEMO_DEV_READ;
CREATE ROLE CICD_DEMO_TEST_OWNER;
CREATE ROLE CICD_DEMO_TEST_WRITE;
CREATE ROLE CICD_DEMO_TEST_READ;
CREATE ROLE CICD_DEMO_PROD_OWNER;
CREATE ROLE CICD_DEMO_PROD_WRITE;
CREATE ROLE CICD_DEMO_PROD_READ;
CREATE ROLE CICD_DEMO_PROD_ANALYTICS_READ;

// warehouse access
CREATE ROLE CICD_DEMO_DEVELOPER_WH_OWNER;
CREATE ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES;

// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_DEV_OWNER                   TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DEV_WRITE                   TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DEV_READ                    TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_TEST_OWNER                  TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_TEST_WRITE                  TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_TEST_READ                   TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_PROD_OWNER                  TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_PROD_WRITE                  TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_PROD_READ                   TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_PROD_ANALYTICS_READ         TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_OWNER          TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES TO ROLE SYSADMIN;
//=============================================================================
 

//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// data access
GRANT OWNERSHIP ON DATABASE CICD_DEMO_DEV                                    TO ROLE CICD_DEMO_DEV_OWNER;
GRANT USAGE, CREATE SCHEMA ON DATABASE CICD_DEMO_DEV                         TO ROLE CICD_DEMO_DEV_WRITE;
GRANT USAGE ON DATABASE CICD_DEMO_DEV                                        TO ROLE CICD_DEMO_DEV_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE CICD_DEMO_DEV                      TO ROLE CICD_DEMO_DEV_READ;
GRANT OWNERSHIP ON DATABASE CICD_DEMO_TEST                                   TO ROLE CICD_DEMO_TEST_OWNER;
GRANT USAGE, CREATE SCHEMA ON DATABASE CICD_DEMO_TEST                        TO ROLE CICD_DEMO_TEST_WRITE;
GRANT USAGE ON DATABASE CICD_DEMO_TEST                                       TO ROLE CICD_DEMO_TEST_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE CICD_DEMO_TEST                     TO ROLE CICD_DEMO_TEST_READ;
GRANT OWNERSHIP ON DATABASE CICD_DEMO_PROD                                   TO ROLE CICD_DEMO_PROD_OWNER;
GRANT USAGE, CREATE SCHEMA ON DATABASE CICD_DEMO_PROD                        TO ROLE CICD_DEMO_PROD_WRITE;
GRANT OWNERSHIP ON SCHEMA CICD_DEMO_PROD.ANALYTICS                           TO ROLE CICD_DEMO_PROD_WRITE;
GRANT USAGE ON DATABASE CICD_DEMO_PROD                                       TO ROLE CICD_DEMO_PROD_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE CICD_DEMO_PROD                     TO ROLE CICD_DEMO_PROD_READ;
GRANT ROLE CICD_DEMO_PROD_ANALYTICS_READ                                     TO ROLE CICD_DEMO_PROD_READ;
GRANT USAGE ON DATABASE CICD_DEMO_PROD                                       TO ROLE CICD_DEMO_PROD_ANALYTICS_READ;
GRANT USAGE ON SCHEMA CICD_DEMO_PROD.ANALYTICS                               TO ROLE CICD_DEMO_PROD_ANALYTICS_READ;
GRANT SELECT ON FUTURE TABLES IN SCHEMA CICD_DEMO_PROD.ANALYTICS             TO ROLE CICD_DEMO_PROD_ANALYTICS_READ;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA CICD_DEMO_PROD.ANALYTICS              TO ROLE CICD_DEMO_PROD_ANALYTICS_READ;
GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN SCHEMA CICD_DEMO_PROD.ANALYTICS TO ROLE CICD_DEMO_PROD_ANALYTICS_READ;

// warehouse access
GRANT OWNERSHIP ON WAREHOUSE CICD_DEMO_DEVELOPER_WH      TO ROLE CICD_DEMO_DEVELOPER_WH_OWNER;
GRANT ALL PRIVILEGES ON WAREHOUSE CICD_DEMO_DEVELOPER_WH TO ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
// BF roles
CREATE ROLE CICD_DEMO_ADMIN;
CREATE ROLE CICD_DEMO_DEVELOPER;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_ADMIN     TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DEVELOPER TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE CICD_DEMO_DEVELOPER TO ROLE CICD_DEMO_ADMIN;

// grant OA roles
GRANT ROLE CICD_DEMO_DEV_OWNER                    TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEV_WRITE                    TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEV_READ                     TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_TEST_OWNER                   TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_TEST_WRITE                   TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_TEST_READ                    TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_PROD_OWNER                   TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_PROD_WRITE                   TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_PROD_READ                    TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_PROD_ANALYTICS_READ          TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_OWNER          TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEV_WRITE                   TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE CICD_DEMO_TEST_READ                   TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE CICD_DEMO_PROD_READ                   TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES TO ROLE CICD_DEMO_DEVELOPER;

// Grant pre-existing source read roles here
//=============================================================================//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// prod warehouse
CREATE WAREHOUSE CICD_DEMO_DBT_PROD_WH
    COMMENT='Warehouse for powering CI production activities for the CI/CD Demo project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// oa roles
CREATE ROLE CICD_DEMO_DBT_PROD_WH_OWNER;
CREATE ROLE CICD_DEMO_DBT_PROD_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_DBT_PROD_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DBT_PROD_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// oa privileges
GRANT OWNERSHIP ON WAREHOUSE CICD_DEMO_DBT_PROD_WH TO ROLE CICD_DEMO_DBT_PROD_WH_OWNER;
GRANT USAGE ON WAREHOUSE CICD_DEMO_DBT_PROD_WH     TO ROLE CICD_DEMO_DBT_PROD_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE TO ROLE CICD_DEMO_ADMIN;

// prod OA roles
GRANT ROLE CICD_DEMO_DBT_PROD_WH_OWNER TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DBT_PROD_WH_USAGE TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_PROD_WRITE        TO ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE;
GRANT ROLE CICD_DEMO_DBT_PROD_WH_USAGE TO ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE;

// grant source read roles here
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_USER
  PASSWORD = 'YGx7YeW3jX2hJFmKh#kQ' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the production (PROD) environment of the CI/CD Demo project.'
  DEFAULT_WAREHOUSE = CICD_DEMO_DBT_PROD_WH
  DEFAULT_ROLE = CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_ROLE TO USER CICD_DEMO_DBT_PROD_SERVICE_ACCOUNT_USER;
//=============================================================================
//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// warehouses
CREATE WAREHOUSE CICD_DEMO_DBT_TEST_WH
    COMMENT='Warehouse for powering CI test activities for the CI/CD Demo project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// OA roles
CREATE ROLE CICD_DEMO_DBT_TEST_WH_OWNER;
CREATE ROLE CICD_DEMO_DBT_TEST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_DBT_TEST_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_DBT_TEST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA privileges
GRANT OWNERSHIP ON WAREHOUSE CICD_DEMO_DBT_TEST_WH TO ROLE CICD_DEMO_DBT_TEST_WH_OWNER;
GRANT USAGE ON WAREHOUSE CICD_DEMO_DBT_TEST_WH     TO ROLE CICD_DEMO_DBT_TEST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE TO ROLE CICD_DEMO_ADMIN;

// test OA roles
GRANT ROLE CICD_DEMO_DBT_TEST_WH_OWNER TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DBT_TEST_WH_USAGE TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_TEST_WRITE        TO ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE;
GRANT ROLE CICD_DEMO_DBT_TEST_WH_USAGE TO ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE;

// grant source read roles here
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_USER
  PASSWORD = '@Mj0*rBIsC2euHoDPL1@' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the test (TEST) environment of the CI/CD Demo project.'
  DEFAULT_WAREHOUSE = CICD_DEMO_DBT_TEST_WH
  DEFAULT_ROLE = CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE TO USER CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_USER;
//=============================================================================
//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// reporting warehouse
CREATE WAREHOUSE CICD_DEMO_SIGMA_ANALYST_WH
    COMMENT='Warehouse for powering analytics queries from Sigma for the CI/CD Demo project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access (OA) roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA roles
CREATE ROLE CICD_DEMO_SIGMA_ANALYST_WH_OWNER;
CREATE ROLE CICD_DEMO_SIGMA_ANALYST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_SIGMA_ANALYST_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE CICD_DEMO_SIGMA_ANALYST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to OA roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA privileges
GRANT OWNERSHIP ON WAREHOUSE CICD_DEMO_SIGMA_ANALYST_WH TO ROLE CICD_DEMO_SIGMA_ANALYST_WH_OWNER;
GRANT USAGE ON WAREHOUSE CICD_DEMO_SIGMA_ANALYST_WH     TO ROLE CICD_DEMO_SIGMA_ANALYST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function (BF) roles and grant access to OA roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE CICD_DEMO_SIGMA_ANALYST;

// grant all roles to sysadmin (always do this)
GRANT ROLE CICD_DEMO_SIGMA_ANALYST TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE CICD_DEMO_SIGMA_ANALYST TO ROLE CICD_DEMO_ADMIN;

// OA role assignment
GRANT ROLE CICD_DEMO_SIGMA_ANALYST_WH_OWNER TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_SIGMA_ANALYST_WH_USAGE TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_PROD_ANALYTICS_READ     TO ROLE CICD_DEMO_SIGMA_ANALYST;
GRANT ROLE CICD_DEMO_SIGMA_ANALYST_WH_USAGE TO ROLE CICD_DEMO_SIGMA_ANALYST;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER CICD_DEMO_SIGMA_ANALYST_SERVICE_ACCOUNT_USER
  PASSWORD = '$aUnGaLR84@6$Q2&Zy5R' // use your own password 
  COMMENT = 'Service account for connecting Sigma to Snowflake for CI/CD Demo analytics.'
  DEFAULT_WAREHOUSE = CICD_DEMO_SIGMA_ANALYST_WH
  DEFAULT_ROLE = CICD_DEMO_SIGMA_ANALYST
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE CICD_DEMO_SIGMA_ANALYST TO USER CICD_DEMO_SIGMA_ANALYST_SERVICE_ACCOUNT_USER;
//=============================================================================
