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

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

COPY .env.example .env

RUN chmod +x ./ubahenv.sh
RUN chmod +x ./startserver.sh

RUN sh ./ubahenv.sh

RUN composer install

RUN php artisan key:generate --show

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . .

# Change current user to www
USER www

#CMD ["php-fpm"]
#ENTRYPOINT ["sh", "./startserver.sh"]

#COPY supervisor /etc/supervisor

#EXPOSE 9000
CMD ["php-fpm"]
#CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf" ]