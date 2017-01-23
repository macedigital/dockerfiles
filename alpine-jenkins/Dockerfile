FROM alpine:edge

# Build arguments
ARG JENKINS_VERSION=2.32.1
ARG JENKINS_HOME=/var/lib/jenkins
ARG JENKINS_USER=jenkins
ARG JENKINS_GROUP=jenkins
ARG JENKINS_UID=1000
ARG JENKINS_GID=1000
ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

# awt-issue: https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+got+java.awt.headless+problem
# weak key signing: https://issues.jenkins-ci.org/browse/INFRA-717
RUN addgroup -g ${JENKINS_GID} ${JENKINS_GROUP} \
    && adduser -H -D -h "$JENKINS_HOME" -u ${JENKINS_UID} -G ${JENKINS_GROUP} -s /sbin/nologin ${JENKINS_USER} \
    && apk -U --no-cache add openjdk8 ttf-dejavu git \
    && apk add --no-cache --virtual .build-deps curl gnupg1 \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver keys.gnupg.net --recv-keys D50582E6 \
    && mkdir -p /usr/share/jenkins -p \
    && curl -SL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
    && curl -SL ${JENKINS_URL}.asc -o /usr/share/jenkins/jenkins.war.asc \
    && gpg --verify /usr/share/jenkins/jenkins.war.asc \
    && echo "$(curl -SL ${JENKINS_URL}.sha1)  /usr/share/jenkins/jenkins.war" | sha1sum -c - \
    && rm -r /usr/share/jenkins/jenkins.war.asc "$GNUPGHOME" \
    && chown -R root:root /usr/share/jenkins \
    && mkdir -p /var/lib/jenkins \
    && chown -R ${JENKINS_USER} /var/lib/jenkins \
    && apk del .build-deps \
    && rm -r /var/cache/apk

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

