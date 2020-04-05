{{ config(tags=["google_analytics", "daily"]) }}

WITH

LANDING_TRAFFIC AS (
  SELECT
    *,
    TRIM(SPLIT_PART(LANDING_PAGE_PATH, '?', 1)) AS LANDING_PAGE_PATH_BASE,
    TRIM(SPLIT_PART(SOURCE_MEDIUM, '/', 1))     AS TRAFFIC_SOURCE,
    TRIM(SPLIT_PART(SOURCE_MEDIUM, '/', 2))     AS TRAFFIC_MEDIUM
  FROM  
    {{ ref('stg_minutely_landing_traffic_by_campaign') }}
)

SELECT * FROM LANDING_TRAFFIC