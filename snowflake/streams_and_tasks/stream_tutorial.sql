
//=============================================================================
// Set context
//=============================================================================
USE ROLE RTE;
USE WAREHOUSE RTE_WH;
USE DATABASE HASHMAP_TRAINING_DB;
USE SCHEMA HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS;
//=============================================================================


//=============================================================================
// CREATE LOOKUP, SOURCE, AND DESTINATION TABLES
//=============================================================================
CREATE OR REPLACE TABLE 
  LOOKUP (
    KEY NUMBER,
    VAL STRING
  );
INSERT INTO LOOKUP VALUES (0, 'SNOWFLAKE'), (1, 'FIVETRAN'), (2, 'LOOKER');

CREATE OR REPLACE TABLE
  SOURCE (
    RAW_DATA VARIANT
);

CREATE OR REPLACE TABLE
  DESTINATION (
    TOOL STRING,
    RATING NUMBER
);
//=============================================================================


//=============================================================================
// Create streams on source table
//=============================================================================
CREATE STREAM STREAM_A ON TABLE SOURCE;
CREATE STREAM STREAM_B ON TABLE SOURCE;

SHOW STREAMS;
//=============================================================================


//=============================================================================
// Modify source and examine streams
//=============================================================================
INSERT INTO SOURCE(RAW_DATA) SELECT PARSE_JSON(' { "Tool": 0, "Rating": 5 } ');

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;

INSERT INTO DESTINATION(TOOL, RATING) (
  SELECT 
    LOOKUP.VAL AS TOOL,
    STREAM_A.RAW_DATA:"Rating" AS RATING
  FROM
    LOOKUP RIGHT OUTER JOIN STREAM_A
    ON LOOKUP.KEY = STREAM_A.RAW_DATA:"Tool"
);

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;

INSERT INTO SOURCE(RAW_DATA) SELECT PARSE_JSON(' { "Tool": 1, "Rating": 5 } ');
INSERT INTO SOURCE(RAW_DATA) SELECT PARSE_JSON(' { "Tool": 2, "Rating": 5 } ');

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;

INSERT INTO DESTINATION(TOOL, RATING) (
  SELECT 
    LOOKUP.VAL AS TOOL,
    STREAM_A.RAW_DATA:"Rating" AS RATING
  FROM
    LOOKUP RIGHT OUTER JOIN STREAM_A
    ON LOOKUP.KEY = STREAM_A.RAW_DATA:"Tool"
);

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;

TRUNCATE TABLE SOURCE;

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;
//=============================================================================


//=============================================================================
// Cleanup
//=============================================================================
DROP TABLE LOOKUP;
DROP TABLE SOURCE;
DROP TABLE DESTINATION;
DROP STREAM STREAM_A;
DROP STREAM STREAM_B;
//=============================================================================
