FROM centurylink/apache-php:latest
MAINTAINER YWKS <yesweekend.smile@gmail.com>

ENV JOOMLA_VERSION 3.3.6

# Install packages
RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor pwgen && \
 apt-get -y install wget unzip && \
 apt-get -y install mysql-client && \
 apt-get -y install postgresql-client

# Download Joomla into /app
RUN rm -fr /app && mkdir /app && \
 wget https://github.com/joomla/joomla-cms/releases/download/$JOOMLA_VERSION/Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip && \
 unzip Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip -d /app  && \
 rm Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip

# Fix permissions for apache
RUN chown -R www-data:www-data /app

EXPOSE 80

CMD ["/run.sh"]
