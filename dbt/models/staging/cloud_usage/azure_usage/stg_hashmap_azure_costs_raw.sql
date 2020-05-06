{{ config(tags=["azure_usage", "daily"]) }}

WITH

STG AS (
  SELECT
    CONVERT_TIMEZONE('America/Chicago', _MODIFIED)                      :: TIMESTAMP_NTZ AS _MODIFIED_CENTRAL_TIME,
    CONVERT_TIMEZONE('America/Chicago', _FIVETRAN_SYNCED)               :: TIMESTAMP_NTZ AS _FIVETRAN_SYNCED_CENTRAL_TIME,

		SPLIT_PART(_FILE, '/', 3) AS COMPUTED_ID,

    {{ 
      dbt_utils.star(
        from=source('azure_costs', 'hashmap_azure_costs'),
        except=[
          "_MODIFIED",
          "_FIVETRAN_SYNCED"
        ]
      ) 
    }}
  FROM
    {{ source('azure_costs', 'hashmap_azure_costs') }}
)

SELECT * FROM STG
 