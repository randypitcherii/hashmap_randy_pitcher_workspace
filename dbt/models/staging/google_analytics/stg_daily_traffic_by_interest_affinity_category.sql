{{ config(tags=["google_analytics", "daily"]) }}

WITH 

TRAFFIC AS (
  SELECT 
    DATE::DATE                         AS DATE,
    INTEREST_AFFINITY_CATEGORY::STRING AS INTEREST_AFFINITY_CATEGORY,
    NEW_USERS::NUMBER                  AS NEW_USERS_COUNT,
    PAGEVIEWS::NUMBER                  AS PAGEVIEWS,
    GOAL_1_COMPLETIONS::NUMBER         AS CONTACT_US_PAGEVIEWS,
    GOAL_2_COMPLETIONS::NUMBER         AS CONTACT_US_FORM_SUBMISSIONS,
    USERS::NUMBER                      AS TOTAL_USERS_COUNT
  FROM 
    {{ source('google_analytics', 'daily_traffic_by_interest_affinity_category') }}
)

SELECT * FROM TRAFFIC