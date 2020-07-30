SELECT
  *

FROM
  {{ ref('ga_hourly_traffic') }}

WHERE 
  -- remove development traffic
  TRAFFIC_HOSTNAME IN ('127.0.0.1', 'localhost') 