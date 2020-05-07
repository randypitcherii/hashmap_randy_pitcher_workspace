{{ config(tags=["snowflake_usage", "daily"]) }}

WITH USAGE AS (
  SELECT 
    CONVERT_TIMEZONE('America/Chicago', START_TIME)::TIMESTAMP_NTZ AS START_TIME_CENTRAL_TIME,
    CONVERT_TIMEZONE('America/Chicago', END_TIME)::TIMESTAMP_NTZ AS END_TIME_CENTRAL_TIME,
    CONVERT_TIMEZONE('America/Chicago', INGESTION_TIME)::TIMESTAMP_NTZ AS INGESTION_TIME_CCENTRAL_TIME,

		{{ 
      dbt_utils.star(
        from=source('snowflake_usage', 'warehouse_metering_history'),
        except=[
          "START_TIME",
          "END_TIME",
          "INGESTION_TIME"
        ]
      ) 
    }}

  FROM 
    {{ source('snowflake_usage', 'warehouse_metering_history') }}
)

SELECT * FROM USAGE