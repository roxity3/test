# Boilerplate for Phoenix Projects

A Template for web app projects using Phoenix Framework 1.3 + Distillery

## What includes?

- Phoenix Framework 1.3 and Elixir 1.4.1
- Distillery for production releases
- Pre hooks for run migrations in production
- Environment variables for settings
- Docker compose setup

## Requirements

- Docker
- Docker Compose
- Cmake

## Considerations for customizations

__TODO__

## Run the project for development

Create docker-compose.yml

    cp docker-compose.yml.example docker-compose.yml

Install the dependencies and create the database

    make bootstrap

Create a new secret for the docker-compose.yml SECRET_KEY_BASE variable

    docker-compose run --rm web mix phoniex.gen.secret

Start the application and all the required containers

    docker-compose up web

## Make a deployment

Create a new release

    make release

Build a new docker images

    docker build -t <NAME:TAG> .

Submit to a repository

    docker push <NAME:TAG>

If you want test the image you can run __docker run__

    docker run -i --rm
    -e "REPLACE_OS_VARS=true"
    -e "PORT=80"
    -e "HOST=www.myhost.com"
    -e "SECRET_KEY_BASE=my_secret_key_base"
    -e "DB_USERNAME=my_db_username"
    -e "DB_PASSWORD=my_db_password"
    -e "DB_HOST=my_db_host"
    -e "DB_PORT=my_db_port"
    -e "DB_NAME=my_db_name"
    -p 80:80 -n myproject <TAG NAME>
