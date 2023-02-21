FROM php:7.4-fpm as base

WORKDIR /var/www/

#install dependencies
RUN apt update \
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
    supervisor \
    #tmux \
    iputils-ping \
    unzip

#Clear cache
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring 
#zip exif pcntl

COPY blogx .

WORKDIR ./blogx

COPY blogx/.env.example .env

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod +x blogx/ubahenv.sh
RUN chmod +x blogx/startserver.sh

RUN sh blogx/ubahenv.sh

RUN composer install

#CMD ["php-fpm"]
#ENTRYPOINT ["sh", "./startserver.sh"]

COPY ./supervisor/ /etc/

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]