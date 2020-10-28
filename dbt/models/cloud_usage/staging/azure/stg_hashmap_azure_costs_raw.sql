{{ config(tags=["azure_usage", "daily"]) }}

WITH

STG AS (
  SELECT
    {{ standardize_timestamp('_MODIFIED') }}        AS _MODIFIED_CENTRAL_TIME,
    {{ standardize_timestamp('_FIVETRAN_SYNCED') }} AS _FIVETRAN_SYNCED_CENTRAL_TIME,

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
 