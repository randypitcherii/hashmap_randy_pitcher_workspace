{{ config(tags=["aws_usage", "azure_usage", "snowflake_usage", "cloud_usage", "daily"]) }}

WITH

AWS_COSTS AS (
  SELECT
    START_DATE_CENTRAL_TIME AS DATETIME_CENTRAL_TIME,
    COST                    AS COST,
    'AWS'                   AS CLOUD
  FROM  
    {{ ref('hashmap_aws_costs') }}
),

AZURE_COSTS AS (
  SELECT
    DATE        AS DATETIME_CENTRAL_TIME,
    COST_IN_USD AS COST,
    'Azure'     AS CLOUD
  FROM  
    {{ ref('hashmap_azure_costs') }}
),

SNOWFLAKE_COSTS AS (
  SELECT
    START_TIME_CENTRAL_TIME AS DATETIME_CENTRAL_TIME,
    3 * CREDITS_USED        AS COST,
    'Snowflake'             AS CLOUD
  FROM  
    {{ ref('snowflake_warehouse_metering_history') }}
),

COSTS AS (
  SELECT * FROM AWS_COSTS
  UNION ALL
  SELECT * FROM AZURE_COSTS
  UNION ALL
  SELECT * FROM SNOWFLAKE_COSTS
)

SELECT * FROM COSTS