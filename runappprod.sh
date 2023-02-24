#! /bin/sh

if (docker container inspect -f '{{.State.Running}}' mysql-db); then
    echo "database is already running"
    if (docker container inspect -f '{{.State.Running}}' web-server); then
        echo "web server is already running"
    else
        docker compose -f prod-compose.yaml up -d web-server
    fi
    
    docker compose -f prod-compose.yaml up -d laravel-app
else
    docker compose -f prod-compose.yaml up -d database
    docker compose -f prod-compose.yaml up -d web-server
    docker compose -f prod-compose.yaml up -d laravel-app
fi