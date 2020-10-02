{{ config(tags=["snowflake_usage", "daily"]) }}

WITH QUERY_HISTORY AS (
  SELECT 
    CONVERT_TIMEZONE('America/Chicago', START_TIME)::TIMESTAMP_NTZ     AS START_TIME_CENTRAL_TIME,
    CONVERT_TIMEZONE('America/Chicago', END_TIME)::TIMESTAMP_NTZ       AS END_TIME_CENTRAL_TIME,
    CONVERT_TIMEZONE('America/Chicago', INGESTION_TIME)::TIMESTAMP_NTZ AS INGESTION_TIME_CENTRAL_TIME,

		{{ 
      dbt_utils.star(
        from=source('snowflake_usage', 'query_history'),
        except=[
          "START_TIME",
          "END_TIME",
          "INGESTION_TIME"
        ]
      ) 
    }}

  FROM 
    {{ source('snowflake_usage', 'query_history') }}
)

SELECT * FROM QUERY_HISTORY