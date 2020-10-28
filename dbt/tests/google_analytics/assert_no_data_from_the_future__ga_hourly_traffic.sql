SELECT
  1

FROM
  {{ ref('ga_hourly_traffic') }}

WHERE 
  TRAFFIC_TIME_CT > {{standardize_timestamp('current_timestamp')}}
  