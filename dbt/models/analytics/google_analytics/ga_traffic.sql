{{ config(tags=["google_analytics", "daily"]) }}

WITH

TRAFFIC AS (
  SELECT 
    * 
  FROM
    {{ dbt_utils.union_relations(
      relations=[
        ref('ga_site_traffic_by_campaign'), 
        ref('ga_landing_traffic_by_campaign'),
        ref('ga_traffic_by_interest_affinity_category'),
        ref('ga_traffic_by_interest_in_market_category')
      ]
    ) }}
)

SELECT * FROM TRAFFIC