{{ config(tags=["google_analytics", "daily"]) }}

WITH

TRAFFIC AS (
  SELECT 
    *
  FROM
    {{ ref('stg_daily_traffic_by_interest_in_market_category') }}
)

SELECT * FROM TRAFFIC
