#! /bin/sh

if (docker container inspect -f '{{.State.Running}}' mysql-db); then
    echo "database is already running"
    docker compose -f prod-compose.yaml up -d laravel-app
    if (docker container inspect -f '{{.State.Running}}' web-server) && [docker container inspect -f '{{.State.Status}}' web-server != 'Exited']; then
        echo "web server is already running"
    else
        docker compose -f prod-compose.yaml up -d web-server
    fi
else
    docker compose -f prod-compose.yaml up -d database
    docker compose -f prod-compose.yaml up -d laravel-app
    docker compose -f prod-compose.yaml up -d web-server
fi