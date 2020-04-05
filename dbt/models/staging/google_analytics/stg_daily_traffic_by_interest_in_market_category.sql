WITH USAGE AS (
  SELECT 
    *
  FROM 
    {{ source('google_analytics', 'daily_traffic_by_interest_in_market_category') }}
)

SELECT * FROM USAGE