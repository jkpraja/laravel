#! /bin/sh

if (docker container inspect -f '{{.State.Running}}' mysql-db) then
    echo "database is already running"
    docker compose up -d laravel-app
else
    docker compose up -d database
    docker compose up -d laravel-app
fi