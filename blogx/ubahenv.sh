#! /bin/bash

sed -i -e '/DB_DATABASE/s/laravel/blogx/g' .env
sed -i -e '/DB_USERNAME/s/root/blogx/g' .env
sed -i -e 's/DB_PASSWORD=/DB_PASSWORD=blogx/g' .env
sed -i -e '/DB_HOST/s/127.0.0.1/mysql/g' .env
