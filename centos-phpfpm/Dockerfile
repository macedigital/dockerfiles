FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

RUN yum install -y epel-release https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && yum install -y \
        php56w-bcmath \
        php56w-fpm \
        php56w-gd \
        php56w-imap \
        php56w-intl \
        php56w-ldap \
        php56w-mbstring \
        php56w-mcrypt \
        php56w-mysqlnd \
        php56w-opcache \
        php56w-pdo \
        php56w-pecl-apcu \
        php56w-pecl-igbinary \
        php56w-pecl-imagick \
        php56w-pecl-memcache \
        php56w-pecl-memcached \
        php56w-pecl-mongodb \
        php56w-pecl-redis \
        php56w-pgsql \
        php56w-process \
        php56w-recode \
        php56w-soap \
        php56w-xml \
    && yum clean all

RUN sed -i s"/listen = 127.0.0.1/listen = 0.0.0.0/" /etc/php-fpm.d/www.conf \
  && sed -i s"/listen.allowed_clients = 127.0.0.1/;listen.allowed_clients = any/" /etc/php-fpm.d/www.conf \
  && sed -i s"/;pm.status_path/pm.status_path/" /etc/php-fpm.d/www.conf \
  && sed -i s"/;ping.path/ping.path/" /etc/php-fpm.d/www.conf \
  && sed -i s"/;catch_workers_output/catch_workers_output/" /etc/php-fpm.d/www.conf \
  && sed -i s"/;chdir/chdir/" /etc/php-fpm.d/www.conf \
  && sed -i s"/;env/env/" /etc/php-fpm.d/www.conf \
  && sed -i s"/slowlog/;slowlog/" /etc/php-fpm.conf \
  && sed -i s"/error_log = \/var\/log\/php-fpm\/error.log/error_log = syslog/" /etc/php-fpm.conf \
  && sed -i s"/^php_admin_value/;php_admin_value/" /etc/php-fpm.d/www.conf \
  && sed -i s"/^php_admin_flag/;php_admin_flag/" /etc/php-fpm.d/www.conf \
  && sed -i s"/;date.timezone =/date.timezone = UTC/" /etc/php.ini \
  && mkdir -p /var/lib/php/{session,wsdlcache} \
  && chown -R apache:apache /var/lib/php

EXPOSE 9000
VOLUME /var/www

CMD ["php-fpm", "-F", "-O"]
