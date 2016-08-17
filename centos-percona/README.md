# Percona-Server with TokuDB engine

![](https://img.shields.io/docker/stars/macedigital/percona.svg "Docker stars")
![](https://img.shields.io/docker/pulls/macedigital/percona.svg "Image pulls")
[![](https://img.shields.io/docker/automated/macedigital/percona.svg)](https://hub.docker.com/r/macedigital/percona/ "Docker Hub page")

Dockerfile for building CentOS 7 containers running Percona-Server 5.7.x supporting the [TokuDB engine](https://www.percona.com/software/mysql-database/percona-tokudb).

[For the TokuDB engine to work, Transparent HugePages must be disabled](https://www.percona.com/blog/2014/07/23/why-tokudb-hates-transparent-hugepages/). This is a known limitation at the moment.

The run script is based on the [offical MySQL docker-entrypoint.sh](https://github.com/docker-library/mysql/blob/master/5.7/docker-entrypoint.sh).

The server's `/etc/my.cnf` file is using some opiniated defaults:
- use strict mode
- prefer native aio for InnoDB table files
- set timezone to UTC
- set characterset to UTF-8.

In order to customize settings you can provide configuration files in ini-format into the `/etc/my.cnf.d/` directory, which is available as a volume.
