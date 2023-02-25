FROM nginx:alpine
WORKDIR /var/www/
#COPY . /var/www/
ADD ./nginx/app.conf /etc/nginx/conf.d/app.conf
#WORKDIR /var/www/