SELECT
  *

FROM
  {{ ref('ga_hourly_traffic') }}

WHERE 
  -- only include results with hosts that are not part of the set of production hostnames in this test
  TRAFFIC_HOSTNAME NOT IN {{ hashmap_google_analytics_production_hostnames() }}
  