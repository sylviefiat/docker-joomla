FROM php:7.0-apache
MAINTAINER sylviefiat <sylvie.fiat@ird.fr>

ENV JOOMLA_VERSION 3.7.2

# Install packages
RUN apt-get update && \
 apt-get -y install wget unzip && \
 apt-get -y install mysql-client sendmail

RUN docker-php-source extract && \
 apt-get update && \
 apt-get install -y libcurl4-gnutls-dev && \
 rm -rf /var/lib/apt/lists/* && \
 docker-php-ext-install pdo pdo_mysql mysqli && \
 docker-php-ext-install curl && \
 a2enmod rewrite && \
 service apache2 restart && \
 docker-php-source delete

# Download Joomla into /app
RUN rm -fr /app && mkdir /app && \
 wget https://github.com/joomla/joomla-cms/releases/download/$JOOMLA_VERSION/Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip && \
 unzip Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip -d /app && \
 rm Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip

# Fix permissions for apache
RUN chown -R www-data:www-data /app
RUN rmdir /var/www/html && \
 ln -s /app /var/www/html

RUN service sendmail restart

EXPOSE 80

