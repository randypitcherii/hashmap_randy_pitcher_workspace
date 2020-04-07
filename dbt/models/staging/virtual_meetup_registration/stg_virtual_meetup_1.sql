{{ config(tags=["virtual_meetup_registration"]) }}

WITH 

REGISTRATIONS AS (
  SELECT 
    *
  FROM 
    {{ source('virtual_meetup_registration', 'virtual_meetup_1') }}
)

SELECT * FROM REGISTRATIONS