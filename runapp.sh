#! /bin/sh

if [ "$( docker container inspect -f \'{{.State.Status}}\' mysql)" == "running" ]
    echo "Mysql is already running"
else
    docker compose up -d mysql
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