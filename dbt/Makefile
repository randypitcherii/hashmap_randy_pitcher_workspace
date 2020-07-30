compile:
	dbt compile

run: deps
	dbt run -x

deps:
	dbt deps

clean:
	dbt run-operation drop_old_relations --args '{cutoff_in_hours: 0}'
	dbt run-operation drop_empty_schemas

runclean: clean run
