# ArchLinux based percona-server (drop-in mysql replacement)
# Version 0.0.1
FROM base/archlinux:latest
MAINTAINER Matthias Adler <macedigital@gmail.com>

# HACK: ignore 'filesystem' package. as it will fail to install due to 
# `/etc/resolv.conf` and `/etc/hosts` being mounted read-only. 
# @link https://github.com/dotcloud/docker/issues/2267
RUN pacman -Syu --force --noconfirm --ignore=filesystem

# install percona server, but do not install a database
RUN pacman -S percona-server --noconfirm
RUN rm -Rf /var/lib/mysql/*

# clean all packages from cache directory to make base image smalller
RUN pacman -Scc --noconfirm

# add default config 
ADD my.cnf /etc/mysql/my.cnf

# add tools scripts
ADD run.sh /usr/local/bin/run.sh
ADD create_mysql_admin_user.sh /usr/local/bin/create_mysql_admin_user.sh
ADD import_sql.sh /usr/local/bin/import_sql.sh
RUN chmod 755 /usr/local/bin/* 

# exposed ENV
ENV MYSQL_PASS **Random**

# make data and config directories docker volumes
VOLUME ["/var/lib/mysql", "/etc/mysql/my.cnf"]

# forward default port
EXPOSE 3306

# run server 
CMD ["run.sh"]
