//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// warehouses
CREATE WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH
    COMMENT='Warehouse for powering CI test activities for the RANDY_PITCHER_WORKSPACE project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// OA roles
CREATE ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_OWNER;
CREATE ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA privileges
GRANT OWNERSHIP ON WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH TO ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_OWNER;
GRANT USAGE ON WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH     TO ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;

// test OA roles
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_OWNER TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_TEST_WRITE        TO ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_WH_USAGE TO ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;
GRANT ROLE FIVETRAN_READ_ROLE                        TO ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;
GRANT ROLE MATILLION_DB_READ                         TO ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE;

// grant source read roles here
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the test (TEST) environment of the CI/CD Demo project.'
  DEFAULT_WAREHOUSE = RANDY_PITCHER_WORKSPACE_DBT_TEST_WH
  DEFAULT_ROLE = RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_ROLE TO USER RANDY_PITCHER_WORKSPACE_DBT_TEST_SERVICE_ACCOUNT_USER;
//=============================================================================
