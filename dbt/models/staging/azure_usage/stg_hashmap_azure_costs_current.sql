{{ config(tags=["azure_usage", "daily"], materialized='table') }}

WITH 

RAW_COSTS AS ( 
	SELECT 
		{{ 
      dbt_utils.star(
        from=ref('stg_hashmap_azure_costs_raw'),
        except=[
          "USAGE_DATE_TIME",
          "USAGE_QUANTITY",
          "RESOURCE_RATE ",
          "PRE_TAX_COST",
          "RESOURCE_TYPE",
          "INSTANCE_ID",
          "SERVICE_NAME",
          "SERVICE_TIER",
          "CURRENCY",
          "SERVICE_INFO_2"
        ]
      ) 
    }}
	FROM 
    {{ ref('stg_hashmap_azure_costs_raw') }}
	WHERE
    USAGE_DATE_TIME IS NULL
    AND PAYG_COST_IN_BILLING_CURRENCY > 0
),

RNK AS (
	SELECT 
		*, 
		RANK() OVER (PARTITION BY COMPUTED_ID ORDER BY _MODIFIED_CENTRAL_TIME DESC) AS RNK
	FROM RAW_COSTS
),

STG AS (
  SELECT
		{{ 
      dbt_utils.star(
        from=ref('stg_hashmap_azure_costs_raw'),
        except=[
          "USAGE_DATE_TIME",
          "USAGE_QUANTITY",
          "RESOURCE_RATE ",
          "PRE_TAX_COST",
          "RESOURCE_TYPE",
          "INSTANCE_ID",
          "SERVICE_NAME",
          "SERVICE_TIER",
          "CURRENCY",
          "SERVICE_INFO_2",
          "RESOURCE_GROUP"
        ]
      ) 
    }},
    split_part(INSTANCE_NAME,'/', -1) AS INSTANCE_ID,
    UPPER(RESOURCE_GROUP) AS RESOURCE_GROUP
  FROM
    RNK
  WHERE
    RNK.RNK = 1
)

SELECT * FROM STG
 