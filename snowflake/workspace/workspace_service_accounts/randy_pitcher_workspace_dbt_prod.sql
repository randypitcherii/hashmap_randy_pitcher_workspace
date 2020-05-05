//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// prod warehouse
CREATE WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH
    COMMENT='Warehouse for powering CI production activities for the RANDY_PITCHER_WORKSPACE project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// oa roles
CREATE ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_OWNER;
CREATE ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// oa privileges
GRANT OWNERSHIP ON WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_OWNER;
GRANT USAGE ON WAREHOUSE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH     TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;

// prod OA roles
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_OWNER TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_PROD_WRITE        TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_WH_USAGE TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
GRANT ROLE FIVETRAN_READ_ROLE                        TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
GRANT ROLE MATILLION_DB_READ                         TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;
GRANT ROLE STITCH_DB_READ                            TO ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE;

// grant source read roles here
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the production (PROD) environment of the CI/CD Demo project.'
  DEFAULT_WAREHOUSE = RANDY_PITCHER_WORKSPACE_DBT_PROD_WH
  DEFAULT_ROLE = RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_ROLE TO USER RANDY_PITCHER_WORKSPACE_DBT_PROD_SERVICE_ACCOUNT_USER;
//=============================================================================
