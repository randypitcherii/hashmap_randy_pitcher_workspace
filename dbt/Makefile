run:
	dbt run -x

test:
	dbt test

compile:
	dbt compile

install:
	dbt deps

clean_target:
	dbt run-operation drop_old_relations --args '{cutoff_in_hours: 0}'
	dbt run-operation drop_empty_schemas

runclean: clean_target run

all: install run test
