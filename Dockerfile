# DOCKER-VERSION 0.4.8
FROM ubuntu:12.04

MAINTAINER Paulo Patto "paulopatto@gmail.com.com"
# Based in https://gist.github.com/deepak/5925003
# Based in http://goo.gl/kSDDU0
# Based in http://goo.gl/hMl6Nq


# USAGE:
# In directory run command
# IF you add self user on docker group, the comand sudo is optional.
#
# ```shell
#   $ sudo docker build .
# ```

RUN apt-get -y install python-software-properties libpq-dev

RUN add-apt-repository -y ppa:ondrej/php5-oldstable
RUN add-apt-repository -y ppa:nginx/stable
RUN add-apt-repository -y ppa:pitti/postgresql
RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C E5267A6C 0xcbcb082a1bb943db
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

RUN apt-get -y update

RUN apt-get install -y nginx-full git postgresql-9.2 postgresql-client-9.2 postgresql-contrib-9.2 php5-fpm php-apc php5-imagick php5-imap php5-mcrypt php5-pgsql lynx vim wget curl sudo openssh-server
RUN git clone --depth 1 -b docker https://github.com/paulopatto/OpenX.git /opt/openx
RUN mkdir -p /var/run/sshd
RUN rm /etc/php5/fpm/php.ini
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /opt/openx/etc/nginx.conf /etc/nginx/sites-enabled/openx.conf
RUN ln -s /opt/openx/php.ini /etc/php5/fpm/php.ini
RUN chown -R www-data:www-data /opt/openx
RUN sudo -u postgres createuser -P -d -r -s docker
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.2/main/postgresql.conf

# Expose ports
# - web: 80 3000 8000 9000
# - ssh: 22, 2222
# - database: 5432
EXPOSE 80 22 2222 9000 3000 8000 5432
CMD service php5-fpm start && nginx
