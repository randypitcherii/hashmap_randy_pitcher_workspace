{{ config(tags=["snowflake_usage", "daily"], materialized='incremental', transient=false) }}

WITH HISTORY AS (
  SELECT 
    CONVERT_TIMEZONE('America/Chicago', START_TIME)::TIMESTAMP_NTZ AS START_TIME_CENTRAL_TIME,
    CONVERT_TIMEZONE('America/Chicago', END_TIME)::TIMESTAMP_NTZ   AS END_TIME_CENTRAL_TIME,

		{{ 
      dbt_utils.star(
        from=source('snowflake_usage', 'warehouse_metering_history'),
        except=[
          "START_TIME",
          "END_TIME"
        ]
      ) 
    }},

    END_TIME AS WATERMARK

  FROM 
    {{ source('snowflake_usage', 'warehouse_load_history') }}

  {% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    WHERE 
      WATERMARK > (SELECT MAX(THIS.WATERMARK) FROM {{ this }} THIS)
  {% endif %}
)

SELECT * FROM HISTORY