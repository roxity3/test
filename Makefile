##################################################################
#### Development Commands
##################################################################

up:
		docker-compose up -d web

restart.web:
		docker-compose restart web

stop.web:
		docker-compose stop web

stop.db:
		docker-compose stop postgres

logs:
		docker-compose logs -f web

shell:
		docker-compose exec web sh

seed:
		docker-compose run --rm web sh -c "mix run priv/repo/seeds.exs"
##################################################################
#### Build and Deployment Commands
##################################################################

bootstrap:
		docker-compose run --rm web sh -c "mix deps.get \
		&& mix deps.clean --unused \
		&& npm --prefix /app/web/static/assets install \
		&& mix ecto.setup"

release:
		MIX_ENV=prod docker-compose run --rm web sh -c "mix compile \
		&& cd /app;/app/node_modules/brunch/bin/brunch build --production \
		&& mix phoenix.digest \
		&& mix release --no-tar --env=prod"
