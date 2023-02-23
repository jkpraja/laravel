#! /bin/sh

if (docker container inspect -f '{{.State.Running}}' mysql-db) then
    echo "database is already running"
    if (docker container inspect -f '{{.State.Running}}' web-server) then
        echo "web server is already running"
    else
        docker compose up -d laravel-server
    fi
    
    docker compose up -d laravel-app
else
    docker compose up -d database
    docker compose up -d laravel-server
    docker compose up -d laravel-app
fi