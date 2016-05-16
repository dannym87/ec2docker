FROM php:7.0.6-fpm

ENV NGINX_VERSION 1.9.9-1~jessie

# Install System Dependencies
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
      && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
      && apt-get update \
      && apt-get install -y ca-certificates nginx=${NGINX_VERSION} nano wget git vim \
      && apt-get clean && apt-get purge \
      && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql

# App code
COPY ./app /var/www/html/app

RUN chown www-data:www-data -R /var/www/html/app

# nginx server blocks
COPY ./nginx/prod/app.conf /etc/nginx/conf.d/default.conf
COPY ./php/prod/php.ini /usr/local/etc/php/php.ini

EXPOSE 80 443
ENTRYPOINT /usr/local/sbin/php-fpm -D && /usr/sbin/nginx -g 'daemon off;'