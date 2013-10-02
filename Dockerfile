# DOCKER-VERSION 0.4.8
FROM ubuntu:12.04

MAINTAINER Paulo Patto "paulopatto@gmail.com.com"
# Based in https://gist.github.com/deepak/5925003
# Based in http://goo.gl/kSDDU0

RUN apt-get -y install python-software-properties

RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu precise main" >> /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/ondrej/php5/ubuntu precise main" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee -a /etc/apt/sources.list.d/10gen.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C E5267A6C 0xcbcb082a1bb943db
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

RUN apt-get -y update

RUN apt-get install -y nginx-full git mongodb-10gen postgresql-9.1 php5-fpm
RUN git clone --depth 1 -b docker https://github.com/paulopatto/OpenX.git /opt/openx
RUN ln -s /opt/openx/etc/nginx.conf /etc/nginx/sites-enabled/openx.conf
RUN chown -R www-data:www-data /opt/openx
