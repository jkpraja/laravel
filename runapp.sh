#! /bin/sh

if [ "$( docker container inspect -f \'{{.State.Status}}\' database)" == "running" ]; then
    echo "database is already running"
else
    docker compose up -d database
fi
docker compose up -d laravel-app
while [ "$( docker container inspect -f \'{{.State.Status}}\' laravel-app)" != "running" ]
    do
        echo "laravel-app is not running yet"
    done
echo "laravel-app is probably running now..."
docker compose exec laravel-app php artisan key:generate
 
docker exec laravel-app php artisan migrate
docker exec laravel-app php artisan serve --host=0.0.0.0