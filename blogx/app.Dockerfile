FROM php:7.4-fpm

WORKDIR /var/www/

#COPY composer.lock composer.json .

#install dependencies
RUN apt update && apt -y full-upgrade \
    && apt -y install lsb-release apt-transport-https ca-certificates \
    #build-essential \
    #libpng-dev \
    #libjpeg62-turbo-dev \
    #libfreetype6-dev \
    #locales \
    #zip \
    libonig-dev \
    #libzip-dev \
    curl \
    git \
    #cron \
    #supervisor \
    #tmux \
    unzip

#Clear cache
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring 
#zip exif pcntl

COPY . ./blogx

WORKDIR ./blogx

COPY .env.example .env

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod +x ./ubahenv.sh

RUN sh ./ubahenv.sh

RUN composer install

#CMD ["php","artisan","key:generate"]

#CMD ["php","artisan","migrate"]

RUN php artisan key:generate && php artisan migrate

CMD ["php", "artisan", "serve", "--host=0.0.0.0"]

#CMD ["php-fpm"]

#COPY ../supervisor/ /etc/

#CMD ["/usr/bin/supervisor", "-c", "/etc/supervisord.conf"]

#RUN sh ./ubahenv.sh && sh ./installcomposer.sh

#RUN php artisan key:generate

#RUN php artisan migrate

#RUN php artisan serve
