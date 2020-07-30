{{ config(tags=["snowflake_usage", "daily"]) }}

WITH

METERING_HISTORY AS (
  SELECT
    START_TIME_CENTRAL_TIME,
    WAREHOUSE_NAME,
    WAREHOUSE_ID,
    CREDITS_USED
  FROM
    {{ ref('stg_hashmap_snowflake_warehouse_metering_history') }}
)

SELECT * FROM METERING_HISTORY