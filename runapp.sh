#! /bin/sh

if [ ! "$( docker ps -a -f name=mysql-db)" ]; then
    echo "database is already running"
    docker compose up -d laravel-app
else
    docker compose up -d database
    docker compose up -d laravel-app
fi