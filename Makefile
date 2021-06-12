test:
	bin/rails test

start:
	bundle exec heroku local

test:
	bin/rails test

lint:
	bundle exec rubocop

linter-fix:
	bundle exec rubocop --auto-correct

heroku-console:
	heroku run rails console

db-docker-run:
	podman run --name hexlet-app-postgres \
		-e POSTGRES_HOST_AUTH_METHOD=trust \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		-d postgres:13-alpine

db-docker-up:
	podman container start hexlet-app-postgres

db-docker-down:
	podman container stop hexlet-app-postgres

db-console:
	bin/rails dbconsole

docker-psql:
	podman exec -it hexlet-app-postgres psql rails_project_lvl2_development -U postgres

.PHONY: test
