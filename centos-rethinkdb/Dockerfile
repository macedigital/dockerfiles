FROM centos:7

# logfile settings is a ugly hack: rethinkdb binary refuses to pipe to stdout while insisting on writing log files
RUN curl -SL http://download.rethinkdb.com/centos/7/x86_64/rethinkdb.repo -o /etc/yum.repos.d/rethinkdb.repo \
    && yum -y install rethinkdb \
    && yum clean all \
    && CONFIG="\
    runuser=rethinkdb \n\
    rungroup=rethinkdb \n\
    directory=/var/lib/rethinkdb/instances.d/default \n\
    log-file=/var/lib/rethinkdb/rethinkdb.log \n\
    bind=all \
    "\
    && echo -e $CONFIG > /etc/rethinkdb/instances.d/default.conf \
    && mkdir -p /var/lib/rethinkdb/instances.d/default \
    && chown -R rethinkdb /var/lib/rethinkdb

ADD run.sh /bin/

USER rethinkdb

VOLUME [ "/var/lib/rethinkdb/instances.d/default" ]

ENTRYPOINT [ "/bin/run.sh" ]
