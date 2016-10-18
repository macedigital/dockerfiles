FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

RUN yum install -y epel-release https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
    && yum install -y --enablerepo=webtatic-testing \
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

COPY php-fpm.conf /etc/php-fpm.conf
COPY www.conf /etc/php-fpm.d/www.conf

RUN mkdir -p /var/lib/php/{session,wsdlcache} && chown -R apache:apache /var/lib/php

EXPOSE 9000

CMD ["php-fpm", "-F", "-O"]
