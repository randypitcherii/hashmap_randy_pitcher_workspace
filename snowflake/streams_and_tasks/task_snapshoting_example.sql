
//=============================================================================
// Create a destination table to send history data to
//=============================================================================
USE ROLE FIVETRAN_ADMIN_ROLE;
CREATE TABLE IF NOT EXISTS
FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE.TASK_USAGE_HISTORY(
  QUERY_ID STRING,
  NAME STRING,
  DATABASE_NAME STRING,
  SCHEMA_NAME STRING,
  QUERY_TEXT STRING,
  CONDITION_TEXT STRING,
  STATE STRING,
  ERROR_CODE STRING,
  ERROR_MESSAGE STRING,
  SCHEDULED_TIME TIMESTAMP_NTZ,
  QUERY_START_TIME TIMESTAMP_NTZ,
  NEXT_SCHEDULED_TIME TIMESTAMP_NTZ,
  COMPLETED_TIME TIMESTAMP_NTZ,
  ROOT_TASK_ID STRING,
  GRAPH_VERSION NUMBER,
  RUN_ID NUMBER,
  RETURN_VALUE STRING,
  INGESTION_TIME TIMESTAMP_NTZ
);
//=============================================================================


//=============================================================================
// Create stored procedure to gather new task usage data
//=============================================================================
USE ROLE SYSADMIN;
CREATE OR REPLACE PROCEDURE HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS.PERSIST_SNOWFLAKE_TASK_HISTORY()
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    STRICT
    EXECUTE AS CALLER
    AS
    $$
        // create array of sql commands
        var sql_commands = [ 
            `INSERT INTO  
              FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE.TASK_USAGE_HISTORY
            SELECT
              QUERY_ID,
              NAME,
              DATABASE_NAME,
              SCHEMA_NAME,
              QUERY_TEXT,
              CONDITION_TEXT,
              STATE,
              ERROR_CODE,
              ERROR_MESSAGE,
              SCHEDULED_TIME :: TIMESTAMP_NTZ,
              QUERY_START_TIME :: TIMESTAMP_NTZ,
              NEXT_SCHEDULED_TIME :: TIMESTAMP_NTZ,
              COMPLETED_TIME :: TIMESTAMP_NTZ,
              ROOT_TASK_ID,
              GRAPH_VERSION,
              RUN_ID,
              RETURN_VALUE,
              CURRENT_TIMESTAMP :: TIMESTAMP_NTZ AS INGESTION_TIME
            FROM
              TABLE(SNOWFLAKE.INFORMATION_SCHEMA.TASK_HISTORY())
            WHERE
              COMPLETED_TIME > (SELECT COALESCE(MAX(COMPLETED_TIME), 0::TIMESTAMP_LTZ) FROM FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE.TASK_USAGE_HISTORY);`
        ];
        
        // execute each command
        sql_commands.forEach(sql => {
            snowflake.execute (
                {sqlText: sql}
            );
        });
        
        return 'done';
    $$
    ;
//=============================================================================


//=============================================================================
// Create a task to run the stored procedure on a schedule
//=============================================================================
CREATE OR REPLACE TASK HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS.PERSIST_SNOWFLAKE_TASK_HISTORY_TASK
  WAREHOUSE=RTE_WH
  SCHEDULE = 'USING CRON 0 0,6,12,18 * * * America/Chicago'
AS
  CALL HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS.PERSIST_SNOWFLAKE_TASK_HISTORY();

// Tasks are suspended by default. Resume the task so it will run on schedule
ALTER TASK HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS.PERSIST_SNOWFLAKE_TASK_HISTORY_TASK RESUME;
//=============================================================================


//=============================================================================
// Cleanup
//=============================================================================
USE ROLE SYSADMIN;
DROP TASK HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS.PERSIST_SNOWFLAKE_TASK_HISTORY_TASK;
DROP TABLE FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE.TASK_USAGE_HISTORY;
DROP PROCEDURE HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS.PERSIST_SNOWFLAKE_TASK_HISTORY();
//=============================================================================