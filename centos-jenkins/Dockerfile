FROM macedigital/jre-server

# Build arguments
ARG JENKINS_VERSION=2.7.4
ARG JENKINS_HOME=/var/lib/jenkins
ARG JENKINS_USER=jenkins
ARG JENKINS_GROUP=jenkins
ARG JENKINS_UID=1000
ARG JENKINS_GID=1000
ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

# Create jenkins user and group
RUN groupadd -g ${JENKINS_GID} ${JENKINS_GROUP} && useradd -d "$JENKINS_HOME" -u ${JENKINS_UID} -g ${JENKINS_GID} -m -s /sbin/nologin ${JENKINS_USER}

# Install git
RUN curl -SL https://copr.fedoraproject.org/coprs/bitshaka/git-2.x/repo/epel-7/bitshaka-git-2.x-epel-7.repo -o /etc/yum.repos.d/bitshaka-git.repo \
    && yum -y install git && yum clean all

# Download and verify jenkins.war, check progress on fixing weak key signing https://issues.jenkins-ci.org/browse/INFRA-717
RUN gpg --keyserver keys.gnupg.net --recv-keys D50582E6 \
    && mkdir -p /usr/share/jenkins -p \
    && curl -SL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
    && curl -SL ${JENKINS_URL}.asc -o /usr/share/jenkins/jenkins.war.asc \
    && gpg --verify /usr/share/jenkins/jenkins.war.asc \
    && echo $(curl -SL ${JENKINS_URL}.sha1) /usr/share/jenkins/jenkins.war | sha1sum -c - \
    && rm /usr/share/jenkins/jenkins.war.asc \
    && chown -R root:root /usr/share/jenkins

# Runtime environment
ENV JENKINS_VERSION ${JENKINS_VERSION}
ENV JENKINS_HOME ${JENKINS_HOME}
ENV JENKINS_HTTP_PORT 8080
ENV JENKINS_SLAVE_AGENT_PORT 50000
ENV JENKINS_UC https://updates.jenkins.io
ENV HOME ${JENKINS_HOME}

# Switch to jenkins user from now on
USER ${JENKINS_USER}

VOLUME ${JENKINS_HOME}

WORKDIR ${JENKINS_HOME}

EXPOSE ${JENKINS_HTTP_PORT}
EXPOSE ${JENKINS_SLAVE_AGENT_PORT}

CMD [ "sh", "-c", "java ${JAVA_OPTS} -jar /usr/share/jenkins/jenkins.war ${JENKINS_OPTS}" ]
