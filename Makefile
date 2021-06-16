install:
	bundle install

setup:
	cp -n .env.example .env || true
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

db-docker-run:
	docker run --name hexlet-app-postgres \
		-e POSTGRES_HOST_AUTH_METHOD=trust \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		-d postgres:13-alpine

db-docker-up:
	docker container start hexlet-app-postgres

db-docker-down:
	docker container stop hexlet-app-postgres

docker-psql:
	docker exec -it hexlet-app-postgres psql rails_project_lvl2_development -U postgres

db-console:
	bin/rails dbconsole

.PHONY: test
