WITH USAGE AS (
  SELECT 
    * 
  FROM 
    {{ source('snowflake_usage', 'warehouse_metering_history') }}
)

SELECT * FROM USAGE