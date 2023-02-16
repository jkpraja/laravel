FROM debian:stable-slim

WORKDIR ./blogx

COPY . .

RUN apt update && apt -y full-upgrade && apt -y install lsb-release apt-transport-https ca-certificates && apt install -y wget && apt install -y git && apt install -y unzip
#RUN composer install

RUN apt -y install php7.4 php7.4-dom php7.4-mbstring php7.4-xml php7.4-mysql php7.4-common php7.4-curl

COPY .env.example .env

#RUN sh ./ubahenv.sh && sh ./installcomposer.sh

#RUN php artisan key:generate

#RUN php artisan migrate

#RUN php artisan serve
