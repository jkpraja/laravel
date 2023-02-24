FROM nginx:alpine
WORKDIR /var/www/
COPY . /var/www/
ADD default.conf /etc/nginx/conf.d/default.conf
#WORKDIR /var/www/