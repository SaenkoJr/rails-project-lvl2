ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

install:
	bundle install

setup:
	bin/setup
	bin/rails db:fixtures:load

db-setup:
	bin/rails db:setup
	bin/rails db:fixtures:load

db-migrate:
	bin/rails db:migrate

test:
	bin/rails test $(ARGS)

start:
	rm -rf tmp/pids/server.pid
	bundle exec rails s -b '0.0.0.0' -p 5000

heroku-start:
	bundle exec heroku local

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop --auto-correct

heroku-console:
	heroku run rails console

ci-setup:
	bundle install --without production
	yarn install
	RAILS_ENV=test bin/rails db:prepare

ci-check: ci-setup lint test

.PHONY: test
