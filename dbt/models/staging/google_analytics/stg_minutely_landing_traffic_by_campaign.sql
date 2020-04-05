WITH USAGE AS (
  SELECT 
    DATE::DATE                                                         AS DATE,
    COUNTRY::STRING                                                    AS COUNTRY,
    CITY::STRING                                                       AS CITY,
    CAMPAIGN::STRING                                                   AS CAMPAIGN,
    LANDING_PAGE_PATH::STRING                                          AS LANDING_PAGE_PATH,
    SOURCE_MEDIUM::STRING                                              AS SOURCE_MEDIUM,
    NEW_USERS::NUMBER                                                  AS NEW_USERS,
    GOAL_2_COMPLETIONS::NUMBER                                         AS CONTACT_US_FORM_SUBMISSIONS,
    USERS::NUMBER                                                      AS USERS,
    PAGEVIEWS::NUMBER                                                  AS PAGEVIEWS,
    GOAL_1_COMPLETIONS::NUMBER                                         AS CONTACT_US_PAGEVIEWS,
    TO_TIMESTAMP_NTZ(DATE_HOUR_MINUTE,'yyyymmddhh24mi')::TIMESTAMP_NTZ AS DATETIME_AMERICA_CHICAGO
  FROM 
    {{ source('google_analytics', 'minutely_landing_traffic_by_campaign') }}
)

SELECT * FROM USAGE