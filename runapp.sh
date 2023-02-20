#! /bin/sh

if [ "$( docker container inspect -f \'{{.State.Status}}\' database)" = "running" ]; then
    echo "database is already running"
    docker compose up -d laravel-app
else
    docker compose up -d
fi

docker compose exec laravel-app php artisan key:generate

while [ "test -d /var/lib/mysql/blogx" -eq 1]
do
    echo "database is not ready"
done

docker exec laravel-app php artisan migrate
docker exec laravel-app php artisan serve --host=0.0.0.0