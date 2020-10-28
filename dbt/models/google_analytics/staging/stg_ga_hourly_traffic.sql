{{ config(tags=["hourly"]) }}

SELECT 
  {{ standardize_timestamp('DATE_HOUR') }} AS TRAFFIC_TIME_CT,
  PROFILE                                  AS TRAFFIC_PROFILE,
  HOSTNAME                                 AS TRAFFIC_HOSTNAME,
  CAMPAIGN                                 AS TRAFFIC_CAMPAIGN,
  PAGE_PATH                                AS TRAFFIC_PAGE_PATH,
  SOURCE_MEDIUM                            AS TRAFFIC_SOURCE_MEDIUM,
  USERS                                    AS TRAFFIC_TOTAL_USERS_CNT,
  NEW_USERS                                AS TRAFFIC_NEW_USERS_CNT,
  PAGEVIEWS                                AS TRAFFIC_PAGEVIEWS_CNT,
  AVG_SESSION_DURATION                     AS TRAFFIC_SESSION_DURATION_AVG

FROM 
  {{ source('google_analytics', 'hourly_traffic') }}