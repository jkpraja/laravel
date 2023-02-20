#! /bin/sh

if [ "$( docker container inspect -f \'{{.State.Status}}\' database)" = "running" ]; then
    echo "database is already running"
else
    docker compose up -d database
    docker compose up -d laravel-app
fi