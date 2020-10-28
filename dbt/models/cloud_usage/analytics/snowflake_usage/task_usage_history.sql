{{ config(tags=["snowflake_usage", "daily"]) }}

WITH USAGE AS (
  SELECT 
    *
  FROM 
    {{ source('fivetran_snowflake_usage', 'task_usage_history') }}
)

SELECT * FROM USAGE