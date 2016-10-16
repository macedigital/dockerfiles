FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

RUN yum install -y epel-release https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
    && yum install -y --enablerepo=webtatic-testing \
         php70w-bcmath \
         php70w-fpm \
         php70w-gd \
         php70w-imap \
         php70w-intl \
         php70w-ldap \
         php70w-mbstring \
         php70w-mcrypt \
         php70w-mysqlnd \
         php70w-opcache \
         php70w-pdo \
         php70w-pecl-apcu \
         php70w-pecl-imagick \
         php70w-pgsql \
         php70w-process \
         php70w-recode \
         php70w-soap \
         php70w-xml \
    && yum clean all

COPY php-fpm.conf /etc/php-fpm.conf
COPY www.conf /etc/php-fpm.d/www.conf

RUN mkdir -p /var/lib/php/{session,wsdlcache} && chown -R apache:apache /var/lib/php

EXPOSE 9000

VOLUME [ "/var/www" ]

CMD ["php-fpm", "-F", "-O"]
