{% macro get_aws_account_name_from_id(account_id_column) %}
  CASE
    WHEN {{ account_id_column }}::STRING = '377692948483' THEN 'Training AWS Account'
    WHEN {{ account_id_column }}::STRING = '660239660726' THEN 'Main AWS Account'
    WHEN {{ account_id_column }}::STRING = '769847333477' THEN 'CDP AWS Account'
    ELSE NULL
  END 
{% endmacro %}