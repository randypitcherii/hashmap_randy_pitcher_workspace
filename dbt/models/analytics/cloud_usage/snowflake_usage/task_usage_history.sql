{{ config(tags=["snowflake_usage", "daily"]) }}

WITH USAGE AS (
  SELECT 
    *
  FROM 
    {{ source('snowflake_usage', 'task_usage_history') }}
)

SELECT * FROM USAGE