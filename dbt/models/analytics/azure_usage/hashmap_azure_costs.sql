{{ config(tags=["azure_usage", "daily"]) }}

WITH

COSTS AS (
  SELECT
    TAGS,
    DATE,
    SERVICE_FAMILY,
    COST_IN_USD,
    LOCATION,
    INSTANCE_ID,
    RESOURCE_GROUP
  FROM
    {{ ref('stg_hashmap_azure_costs_current') }}
)

SELECT * FROM COSTS
