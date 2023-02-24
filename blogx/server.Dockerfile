FROM nginx:alpine
WORKDIR /var/www/
COPY . /var/www/html
ADD default.conf /etc/nginx/conf.d/default.conf
#WORKDIR /var/www/