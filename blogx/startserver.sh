#! /bin/sh

if [ ping -c 2 database > /dev/null ]; then
    echo "database is already running"
    php artisan key:generate
    php artisan migrate
    php artisan serve --host=0.0.0.0 
else
    echo "database is not running yet"
fi