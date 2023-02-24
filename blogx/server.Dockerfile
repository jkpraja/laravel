FROM nginx:alpine
WORKDIR /var/www/
COPY ./blogx/public /var/www/public
ADD default.conf /etc/nginx/conf.d/default.conf
#WORKDIR /var/www/