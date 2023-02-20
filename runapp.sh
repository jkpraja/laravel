#! /bin/sh

if [ "$( docker container inspect -f \'{{.State.Status}}\' database)" = "running" ]; then
    echo "database is already running"
    docker compose up -d laravel-app
    docker compose exec laravel-app php artisan key:generate
    
else
    docker compose up -d database
    docker compose up -d laravel-app
    docker compose exec laravel-app php artisan key:generate
    docker compose exec laravel-app php artisan migrate
fi
docker compose exec laravel-app php artisan serve --host=0.0.0.0