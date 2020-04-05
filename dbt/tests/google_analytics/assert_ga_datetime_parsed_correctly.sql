WITH

UNIONED_DATES AS (
  SELECT 
    *
  FROM
    {{ dbt_utils.union_relations(
      relations=[ref('stg_minutely_site_traffic_by_campaign'), ref('stg_minutely_landing_traffic_by_campaign')],
      include=['DATE', 'DATETIME_AMERICA_CHICAGO']
  ) }}
)

SELECT
  'FAILED DATE PARSE',
  _dbt_source_relation AS FAILING_RELATION
FROM 
  UNIONED_DATES
WHERE
  DATE_TRUNC(DAY, DATETIME_AMERICA_CHICAGO) != DATE;

