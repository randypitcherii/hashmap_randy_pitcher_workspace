SELECT
  1

FROM
  {{ ref('ga_hourly_traffic') }}

WHERE 
  TRAFFIC_TIME_CT > current_timestamp
  