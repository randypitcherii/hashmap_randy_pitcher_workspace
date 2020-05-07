//=============================================================================
// Set context
//=============================================================================
USE ROLE RTE;
USE WAREHOUSE RTE_WH;
USE DATABASE HASHMAP_TRAINING_DB;
USE SCHEMA HASHMAP_TRAINING_DB.VIRTUAL_MEETUP_2_STREAMS_AND_TASKS;
//=============================================================================


//=============================================================================
// Create tables and add show data
//=============================================================================
CREATE OR REPLACE TABLE
  NETFLIX_RATING_EVENTS(
    RAW_DATA VARIANT
);

CREATE OR REPLACE TABLE
  NETFLIX_RATINGS(
    SHOW_ID NUMBER,
    SHOW_TITLE STRING,
    RATING NUMBER
);

CREATE OR REPLACE TABLE 
  NETFLIX_SHOWS(
    ID NUMBER,
    TITLE STRING
);

INSERT INTO 
  NETFLIX_SHOWS // Shows added in no particular order
VALUES 
  (0, 'BoJack Horseman'), // <--- This is the best show on Netflix
  (1, 'Ozark'), 
  (2, 'Master of None'), 
  (3, 'Mindhunter'),  
  (4, 'The Haunting of Hill House'), 
  (5, 'Tiger King'), 
  (6, 'Stranger Things');
//=============================================================================


//=============================================================================
// Create 2 streams on the NETFLIX_RATING_EVENTS table
//=============================================================================
CREATE OR REPLACE STREAM STREAM_A ON TABLE NETFLIX_RATING_EVENTS;
CREATE OR REPLACE STREAM STREAM_B ON TABLE NETFLIX_RATING_EVENTS;

SHOW STREAMS;
//=============================================================================


//=============================================================================
// Modify NETFLIX_RATING_EVENTS and examine streams
//=============================================================================
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 0, "rating": 10 } ');

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;


INSERT INTO NETFLIX_RATINGS(SHOW_ID, SHOW_TITLE, RATING) (
  SELECT 
    NETFLIX_SHOWS.ID AS SHOW_ID,
    NETFLIX_SHOWS.TITLE AS SHOW_TITLE,
    STREAM_A.RAW_DATA:"rating" AS RATING
  FROM
    NETFLIX_SHOWS RIGHT OUTER JOIN STREAM_A
    ON NETFLIX_SHOWS.ID = STREAM_A.RAW_DATA:"show_id"
  WHERE
    STREAM_A.RAW_DATA:"rating" IS NOT NULL
);

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;


INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 1, "rating": 9 } ');
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 2, "rating": 8 } ');

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;


INSERT INTO NETFLIX_RATINGS(SHOW_ID, SHOW_TITLE, RATING) (
  SELECT 
    NETFLIX_SHOWS.ID AS SHOW_ID,
    NETFLIX_SHOWS.TITLE AS SHOW_TITLE,
    STREAM_A.RAW_DATA:"rating" AS RATING
  FROM
    NETFLIX_SHOWS RIGHT OUTER JOIN STREAM_A
    ON NETFLIX_SHOWS.ID = STREAM_A.RAW_DATA:"show_id"
  WHERE
    STREAM_A.RAW_DATA:"rating" IS NOT NULL
);

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;


DELETE FROM NETFLIX_RATING_EVENTS WHERE RAW_DATA:"rating" IS NOT NULL;

SELECT * FROM STREAM_A;
SELECT * FROM STREAM_B;
//=============================================================================


//=============================================================================
// Automate stream ingestion with a task
//=============================================================================
CREATE OR REPLACE TASK NETFLIX_RATINGS_EVENT_PROCESSOR
  WAREHOUSE = RTE_WH
  SCHEDULE  = 'USING CRON * * * * * America/Chicago' // process new records every minute
AS
  INSERT INTO NETFLIX_RATINGS(SHOW_ID, SHOW_TITLE, RATING) (
    SELECT 
      NETFLIX_SHOWS.ID AS SHOW_ID,
      NETFLIX_SHOWS.TITLE AS SHOW_TITLE,
      STREAM_A.RAW_DATA:"rating" AS RATING
    FROM
      NETFLIX_SHOWS RIGHT OUTER JOIN STREAM_A
      ON NETFLIX_SHOWS.ID = STREAM_A.RAW_DATA:"show_id"
    WHERE
      STREAM_A.RAW_DATA:"rating" IS NOT NULL
  );

// Tasks are suspended by default. Resume the task so it will run on schedule
ALTER TASK NETFLIX_RATINGS_EVENT_PROCESSOR RESUME;

// add new events
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 3, "rating": 8 } ');
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 4, "rating": 8 } ');
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 5, "rating": 7 } ');
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "show_id": 6, "rating": 9 } ');
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "action_id": 0, "platform": 9.75} ');
INSERT INTO NETFLIX_RATING_EVENTS(RAW_DATA) SELECT PARSE_JSON(' { "action_id": 2, "user_id": 978234} ');
//=============================================================================

//=============================================================================
// Cleanup
//=============================================================================
DROP TASK   NETFLIX_RATINGS_EVENT_PROCESSOR;
DROP TABLE  NETFLIX_SHOWS;
DROP TABLE  NETFLIX_RATING_EVENTS;
DROP TABLE  NETFLIX_RATINGS;
DROP STREAM STREAM_A;
DROP STREAM STREAM_B;
//=============================================================================
