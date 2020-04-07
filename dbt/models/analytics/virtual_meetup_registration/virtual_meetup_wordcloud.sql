{{ config(tags=["virtual_meetup_registration"]) }}

WITH 

WORDCLOUD AS (
  SELECT 
    LF.*
  FROM
    {{ ref('virtual_meetup_registrations') }} VMR,
  LATERAL FLATTEN (
    INPUT => SPLIT(VMR.WHAT_ARE_YOU_MOST_EXCITED_TO_HEAR_ABOUT_IN_THIS_SESSION_,',')
  ) LF
)

SELECT * FROM WORDCLOUD