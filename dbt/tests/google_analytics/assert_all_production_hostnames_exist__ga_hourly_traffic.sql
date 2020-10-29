SELECT
  COUNT(DISTINCT TRAFFIC_HOSTNAME) NUMBER_OF_UNIQUE_HOSTNAMES

FROM
  {{ ref('ga_hourly_traffic') }}

HAVING 
  -- Check the hashmap_google_analytics_production_hostnames macro to find the correct number here.
  -- at the time of writing this test, the number is 6
  NUMBER_OF_UNIQUE_HOSTNAMES != 6
  