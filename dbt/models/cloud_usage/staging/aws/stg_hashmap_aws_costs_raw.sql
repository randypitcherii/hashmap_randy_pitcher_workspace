{{ config(tags=["aws_usage", "daily"]) }}

WITH

STG AS (
  SELECT
    {{ standardize_timestamp('_MODIFIED') }}                      AS _MODIFIED_CENTRAL_TIME,
    {{ standardize_timestamp('BILL_BILLING_PERIOD_START_DATE') }} AS BILL_BILLING_PERIOD_START_DATE_CENTRAL_TIME,
    {{ standardize_timestamp('BILL_BILLING_PERIOD_END_DATE') }}   AS BILL_BILLING_PERIOD_END_DATE_CENTRAL_TIME,
    {{ standardize_timestamp('LINE_ITEM_USAGE_START_DATE') }}     AS LINE_ITEM_USAGE_START_DATE_CENTRAL_TIME,
    {{ standardize_timestamp('LINE_ITEM_USAGE_END_DATE') }}       AS LINE_ITEM_USAGE_END_DATE_CENTRAL_TIME,
    {{ standardize_timestamp('_FIVETRAN_SYNCED') }}               AS _FIVETRAN_SYNCED_CENTRAL_TIME,

		HASH(
			LINE_ITEM_RESOURCE_ID,
			IDENTITY_TIME_INTERVAL,
			LINE_ITEM_USAGE_TYPE,
			LINE_ITEM_USAGE_START_DATE
		) AS COMPUTED_ID,

    {{ 
      dbt_utils.star(
        from=source('aws_costs', 'hashmap_aws_costs'),
        except=[
          "_MODIFIED",
          "BILL_BILLING_PERIOD_START_DATE",
          "BILL_BILLING_PERIOD_END_DATE",
          "LINE_ITEM_USAGE_START_DATE",
          "LINE_ITEM_USAGE_END_DATE",
          "_FIVETRAN_SYNCED"
        ]
      ) 
    }}
    
  FROM
    {{ source('aws_costs', 'hashmap_aws_costs') }}
)

SELECT * FROM STG
 