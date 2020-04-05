//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// reporting warehouse
CREATE WAREHOUSE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH
    COMMENT='Warehouse for powering analytics queries from Sigma for the RANDY_PITCHER_WORKSPACE project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access (OA) roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA roles
CREATE ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_OWNER;
CREATE ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to OA roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA privileges
GRANT OWNERSHIP ON WAREHOUSE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH TO ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_OWNER;
GRANT USAGE ON WAREHOUSE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH     TO ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function (BF) roles and grant access to OA roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST;

// grant all roles to sysadmin (always do this)
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;

// OA role assignment
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_OWNER TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE TO ROLE RANDY_PITCHER_WORKSPACE_ADMIN;
GRANT ROLE RANDY_PITCHER_WORKSPACE_PROD_ANALYTICS_READ     TO ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST;
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH_USAGE TO ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for connecting Sigma to Snowflake for CI/CD Demo analytics.'
  DEFAULT_WAREHOUSE = RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_WH
  DEFAULT_ROLE = RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST TO USER RANDY_PITCHER_WORKSPACE_SIGMA_ANALYST_SERVICE_ACCOUNT_USER;
//=============================================================================
