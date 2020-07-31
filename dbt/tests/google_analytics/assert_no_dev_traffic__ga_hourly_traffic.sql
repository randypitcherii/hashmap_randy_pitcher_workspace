SELECT
  *

FROM
  {{ ref('ga_hourly_traffic') }}

WHERE 
  -- remove development traffic
  TRAFFIC_HOSTNAME IN ('127.0.0.1', 'localhost', '0.0.0.0', 'recommender.hashmapinc.com.s3-website-us-east-1.amazonaws.com') 