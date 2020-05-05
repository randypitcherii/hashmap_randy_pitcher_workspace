{{ config(tags=["aws_usage", "daily"]) }}

WITH

COSTS AS (
  SELECT
    LINE_ITEM_USAGE_START_DATE_CENTRAL_TIME                          AS START_DATE_CENTRAL_TIME,
    LINE_ITEM_USAGE_ACCOUNT_ID                                       AS ACCOUNT_ID,
    LINE_ITEM_UNBLENDED_COST                                         AS COST,
    PRODUCT_REGION                                                   AS REGION,
    PRODUCT_SERVICECODE                                              AS SERVICE,
    PRODUCT_USAGETYPE                                                AS USAGE_TYPE,
    RESOURCE_TAGS_AWS_CREATED_BY                                     AS CREATED_BY,
    LINE_ITEM_RESOURCE_ID                                            AS RESOURCE_ID,
    {{ get_aws_account_name_from_id('LINE_ITEM_USAGE_ACCOUNT_ID') }} AS ACCOUNT_NAME
  FROM
    {{ ref('stg_hashmap_aws_costs_current') }}
)

SELECT * FROM COSTS
