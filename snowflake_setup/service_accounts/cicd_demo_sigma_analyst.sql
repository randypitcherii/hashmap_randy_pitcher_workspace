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
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for connecting Sigma to Snowflake for CI/CD Demo analytics.'
  DEFAULT_WAREHOUSE = CICD_DEMO_SIGMA_ANALYST_WH
  DEFAULT_ROLE = CICD_DEMO_SIGMA_ANALYST
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE CICD_DEMO_SIGMA_ANALYST TO USER CICD_DEMO_SIGMA_ANALYST_SERVICE_ACCOUNT_USER;
//=============================================================================
