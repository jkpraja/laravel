FROM nginx:alpine
WORKDIR /var/www/
COPY public /var/www/public
ADD default.conf /etc/nginx/conf.d/default.conf
#WORKDIR /var/www/