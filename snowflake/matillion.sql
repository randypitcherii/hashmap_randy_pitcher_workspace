//=============================================================================
// create databases
//=============================================================================
USE ROLE SYSADMIN;

CREATE DATABASE MATILLION_DB 
  COMMENT='Database for MATILLION ingestion.';
//=============================================================================


//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;
  
CREATE WAREHOUSE MATILLION_INGESTION_WH
  COMMENT='Warehouse for data ingestion from Matillion'
  WAREHOUSE_SIZE=XSMALL
  AUTO_SUSPEND=60
  INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// data access
CREATE ROLE MATILLION_DB_READ  COMMENT='Role for reading all relations in all schemas in the MATILLION_DB database';
CREATE ROLE MATILLION_DB_OWNER COMMENT='Role for owning and having unabridged access to the MATILLION_DB database';

// warehouse access
CREATE ROLE MATILLION_INGESTION_WH_ALL_PRIVILEGES COMMENT='Role for full usage and modification of the MATILLION_INGESTION_WH';

// grant all roles to sysadmin (always do this)
GRANT ROLE MATILLION_DB_READ                     TO ROLE SYSADMIN;
GRANT ROLE MATILLION_DB_OWNER                    TO ROLE SYSADMIN;
GRANT ROLE MATILLION_INGESTION_WH_ALL_PRIVILEGES TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// data permissions
GRANT OWNERSHIP ON DATABASE MATILLION_DB               TO ROLE MATILLION_DB_OWNER;
GRANT USAGE ON DATABASE MATILLION_DB                   TO ROLE MATILLION_DB_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE MATILLION_DB TO ROLE MATILLION_DB_READ;
GRANT SELECT ON FUTURE TABLES IN DATABASE MATILLION_DB TO ROLE MATILLION_DB_READ;
GRANT SELECT ON FUTURE VIEWS IN DATABASE MATILLION_DB  TO ROLE MATILLION_DB_READ;

// warehouse permissions
GRANT ALL PRIVILEGES ON WAREHOUSE MATILLION_INGESTION_WH TO ROLE MATILLION_INGESTION_WH_ALL_PRIVILEGES;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE MATILLION_SERVICE_ACCOUNT_ROLE COMMENT='Role for the exclusive usage of the MATILLION_SERVICE_ACCOUNT_USER. This role allows MATILLION to load data into Snowflake.';
 
// grant all roles to sysadmin (always do this)
GRANT ROLE MATILLION_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// OA role assignment
GRANT ROLE MATILLION_DB_OWNER                    TO ROLE MATILLION_SERVICE_ACCOUNT_ROLE;
GRANT ROLE MATILLION_INGESTION_WH_ALL_PRIVILEGES TO ROLE MATILLION_SERVICE_ACCOUNT_ROLE;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER MATILLION_SERVICE_ACCOUNT_USER 
  COMMENT = 'Service account for MATILLION.'
  DEFAULT_WAREHOUSE = MATILLION_INGESTION_WH
  DEFAULT_ROLE = MATILLION_SERVICE_ACCOUNT_ROLE
  RSA_PUBLIC_KEY='your_key_here'
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE MATILLION_SERVICE_ACCOUNT_ROLE TO USER MATILLION_SERVICE_ACCOUNT_USER;
//=============================================================================