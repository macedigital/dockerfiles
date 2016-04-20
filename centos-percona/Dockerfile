# Percona-Server 5.7.x
FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

# Setup packages for installing TokuDB engine
RUN yum update -y \
    && rpmkeys --import https://www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona \
    && yum install -y https://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm \
    && yum install -y Percona-Server-tokudb-57 which policycoreutils \
    && yum clean all

# Configure Percona
ADD my.cnf /etc/my.cnf
ADD run.sh /bin/run.sh

EXPOSE 3306
VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["run.sh"]
CMD ["mysqld"]
