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
GRANT ROLE CICD_DEMO_DEVELOPER_WH_OWNER           TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES  TO ROLE CICD_DEMO_ADMIN;
GRANT ROLE CICD_DEMO_DEV_WRITE                    TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE CICD_DEMO_TEST_READ                    TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE CICD_DEMO_PROD_READ                    TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE CICD_DEMO_DEVELOPER_WH_ALL_PRIVILEGES  TO ROLE CICD_DEMO_DEVELOPER;
GRANT ROLE FIVETRAN_READ_ROLE                     TO ROLE CICD_DEMO_DEV;

// Grant pre-existing source read roles here
//=============================================================================