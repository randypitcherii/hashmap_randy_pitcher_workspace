{{ config(tags=["google_analytics", "daily"]) }}

WITH

SITE_TRAFFIC AS (
  SELECT
    *,
    TRIM(SPLIT_PART(PAGE_PATH, '?', 1))     AS PAGE_PATH_BASE,
    TRIM(SPLIT_PART(SOURCE_MEDIUM, '/', 1)) AS TRAFFIC_SOURCE,
    TRIM(SPLIT_PART(SOURCE_MEDIUM, '/', 2)) AS TRAFFIC_MEDIUM
  FROM  
    {{ ref('stg_minutely_site_traffic_by_campaign') }}
)

SELECT * FROM SITE_TRAFFIC