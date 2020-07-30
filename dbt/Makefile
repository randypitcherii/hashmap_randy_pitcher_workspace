run:
	dbt run -x

test:
	dbt test

all:
	dbt run -x
	dbt test

compile:
	dbt compile

install:
	dbt deps

clean:
	dbt run-operation drop_old_relations --args '{cutoff_in_hours: 0}'
	dbt run-operation drop_empty_schemas

runclean: clean run
