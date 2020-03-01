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
GRANT ROLE FIVETRAN_READ_ROLE          TO ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE;

// grant source read roles here
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the test (TEST) environment of the CI/CD Demo project.'
  DEFAULT_WAREHOUSE = CICD_DEMO_DBT_TEST_WH
  DEFAULT_ROLE = CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_ROLE TO USER CICD_DEMO_DBT_TEST_SERVICE_ACCOUNT_USER;
//=============================================================================
