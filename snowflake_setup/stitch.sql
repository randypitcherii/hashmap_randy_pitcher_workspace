//=============================================================================
// create databases
//=============================================================================
USE ROLE SYSADMIN;

CREATE DATABASE STITCH_DB 
  COMMENT='Database for Stitch ingestion. See https://www.stitchdata.com';
//=============================================================================


//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;
  
CREATE WAREHOUSE STITCH_INGESTION_WH
  COMMENT='Warehouse for data ingestion from Stitch'
  WAREHOUSE_SIZE=XSMALL
  AUTO_SUSPEND=60
  INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// data access
CREATE ROLE STITCH_DB_READ  COMMENT='Role for reading all relations in all schemas in the STITCH_DB database';
CREATE ROLE STITCH_DB_OWNER COMMENT='Role for owning and having unabridged access to the STITCH_DB database';

// warehouse access
CREATE ROLE STITCH_INGESTION_WH_ALL_PRIVILEGES COMMENT='Role for full usage and modification of the STITCH_INGESTION_WH';

// grant all roles to sysadmin (always do this)
GRANT ROLE STITCH_DB_READ                     TO ROLE SYSADMIN;
GRANT ROLE STITCH_DB_OWNER                    TO ROLE SYSADMIN;
GRANT ROLE STITCH_INGESTION_WH_ALL_PRIVILEGES TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// data permissions
GRANT OWNERSHIP ON DATABASE STITCH_DB                           TO ROLE STITCH_DB_OWNER;
GRANT USAGE ON DATABASE STITCH_DB                               TO ROLE STITCH_DB_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE STITCH_DB             TO ROLE STITCH_DB_READ;
GRANT SELECT ON FUTURE TABLES IN DATABASE STITCH_DB             TO ROLE STITCH_DB_READ;
GRANT SELECT ON FUTURE VIEWS IN DATABASE STITCH_DB              TO ROLE STITCH_DB_READ;
GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN DATABASE STITCH_DB TO ROLE STITCH_DB_READ;

// warehouse permissions
GRANT ALL PRIVILEGES ON WAREHOUSE STITCH_INGESTION_WH TO ROLE STITCH_INGESTION_WH_ALL_PRIVILEGES;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE STITCH_SERVICE_ACCOUNT_ROLE;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE STITCH_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// OA role assignment
GRANT ROLE STITCH_DB_OWNER                    TO ROLE STITCH_SERVICE_ACCOUNT_ROLE;
GRANT ROLE STITCH_INGESTION_WH_ALL_PRIVILEGES TO ROLE STITCH_SERVICE_ACCOUNT_ROLE;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER STITCH_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for Stitch.'
  DEFAULT_WAREHOUSE = STITCH_INGESTION_WH
  DEFAULT_ROLE = STITCH_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE STITCH_SERVICE_ACCOUNT_ROLE TO USER STITCH_SERVICE_ACCOUNT_USER;
//=============================================================================