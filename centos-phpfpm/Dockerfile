FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

RUN yum install -y epel-release https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
    && yum update -y \
    && yum install -y php70w-bcmath php70w-fpm php70w-gd php70w-imap php70w-intl php70w-ldap php70w-mbstring \
        php70w-mcrypt php70w-mysqlnd php70w-opcache php70w-pdo php70w-pecl-apcu php70w-pecl-imagick php70w-pgsql \
        php70w-process php70w-recode php70w-soap php70w-xml \
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
