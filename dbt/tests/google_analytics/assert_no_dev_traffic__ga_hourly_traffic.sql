SELECT
  *

FROM
  {{ ref('ga_hourly_traffic') }}

WHERE 
  -- remove development traffic
  TRAFFIC_HOSTNAME NOT IN ('hashmapinc.com', 'profiler.snowflakeinspector.com', 'recommender.hashmapinc.com', 'snowflakeinspector.hashmapinc.com') 
  