install:
	bundle install

setup:
	bin/setup
	bin/rails db:fixtures:load

test:
	bin/rails test

start:
	bundle exec heroku local

lint:
	bundle exec rubocop

linter-fix:
	bundle exec rubocop --auto-correct

heroku-console:
	heroku run rails console

db-podman-run:
	podman run --name hexlet-app-postgres \
		-e POSTGRES_HOST_AUTH_METHOD=trust \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		-d postgres:13-alpine

db-podman-up:
	podman container start hexlet-app-postgres

podman-h:
	podman -h

db-podman-down:
	podman container stop hexlet-app-postgres

podman-psql:
	podman exec -it hexlet-app-postgres psql rails_project_lvl2_development -U postgres

db-console:
	bin/rails dbconsole

.PHONY: test
