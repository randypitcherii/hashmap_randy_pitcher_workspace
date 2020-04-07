{{ config(tags=["virtual_meetup_registration"]) }}

WITH 

UNIONED_REGISTRATIONS AS (
  SELECT 
    * 
  FROM
    {{ dbt_utils.union_relations(
      relations=[
        ref('stg_virtual_meetup_1')
      ]
    ) }}
),

SAFE_REGISTRATIONS AS (
  SELECT
  {{ 
    dbt_utils.star(
      from=ref('stg_virtual_meetup_1'), 
      except=[
        "_FILE",
        "_LINE",
        "FIRST_NAME",
        "LAST_NAME",
        "EMAIL", 
        "_FIVETRAN_SYNCED"]
    ) 
  }},
  _DBT_SOURCE_RELATION AS VIRTUAL_MEETUP_SOURCE
)

SELECT * FROM SAFE_REGISTRATIONS