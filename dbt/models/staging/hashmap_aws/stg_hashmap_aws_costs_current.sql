{{ config(tags=["hashmap_aws", "daily"], materialized='table') }}

WITH 

RAW_COSTS AS ( 
	SELECT 
		*
	FROM 
    {{ ref('stg_hashmap_aws_costs_raw') }}
	WHERE LINE_ITEM_UNBLENDED_COST > 0
),

RNK AS (
	SELECT 
		*, 
		RANK() OVER (PARTITION BY COMPUTED_ID ORDER BY _FIVETRAN_SYNCED_CENTRAL_TIME DESC) AS RNK
	FROM RAW_COSTS
),

STG AS (
  SELECT
    {{ dbt_utils.star(from=ref('stg_hashmap_aws_costs_raw')) }}
  FROM
    RNK
  WHERE
    RNK.RNK = 1
)

SELECT * FROM STG
 