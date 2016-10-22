# Base image for running JVM based applications
FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

ARG VERSION=8
ARG UPDATE=112
ARG BUILD=15
ARG ARCHIVE=server-jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz
ARG TARGET=/usr/lib/jdk1."${VERSION}".0_"${UPDATE}"

RUN curl -SLO --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/"${ARCHIVE}" \
    && curl -SL https://www.oracle.com/webfolder/s/digest/"${VERSION}"u"${UPDATE}"checksum.html \
        | grep $(sha256sum "${ARCHIVE}" | cut -d ' ' -f1) \
        | grep -q "${ARCHIVE}" \
    && tar -xf "${ARCHIVE}" -C $(dirname $TARGET) \
    && rm "${ARCHIVE}" \
    && chown root:root -R "${TARGET}" \
    && alternatives --install /usr/bin/java java "${TARGET}/jre/bin/java" 1000

ENV JAVA_HOME "${TARGET}"
ENV JAVA_OPTS="-Djavax.servlet.request.encoding=UTF-8 -Dfile.encoding=UTF-8 -Djava.awt.headless=true -Duser.timezone=UTC"
ENV PATH "${JAVA_HOME}/jre/bin":$PATH
