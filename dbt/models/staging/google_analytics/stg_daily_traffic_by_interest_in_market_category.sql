{{ config(tags=["google_analytics", "daily"]) }}

WITH

TRAFFIC AS (
  SELECT 
    DATE::DATE                          AS DATE,
    INTEREST_IN_MARKET_CATEGORY::STRING AS INTEREST_IN_MARKET_CATEGORY,
    NEW_USERS::NUMBER                   AS NEW_USERS_COUNT,
    PAGEVIEWS::NUMBER                   AS PAGEVIEWS,
    GOAL_1_COMPLETIONS::NUMBER          AS CONTACT_US_PAGEVIEWS,
    GOAL_2_COMPLETIONS::NUMBER          AS CONTACT_US_FORM_SUBMISSIONS,
    USERS::NUMBER                       AS TOTAL_USERS_COUNT
  FROM 
    {{ source('google_analytics', 'daily_traffic_by_interest_in_market_category') }}
)

SELECT * FROM TRAFFIC