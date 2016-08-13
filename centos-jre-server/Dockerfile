# Base image for running JVM based applications
FROM centos:7
MAINTAINER Matthias Adler <macedigital@gmail.com>

ARG VERSION=8
ARG UPDATE=102
ARG BUILD=14
ARG ARCHIVE=server-jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz
ARG FOLDER=jdk1."${VERSION}".0_"${UPDATE}"

ENV JAVA_HOME /usr/lib/"${FOLDER}"
ENV JAVA_OPTS="-Djavax.servlet.request.encoding=UTF-8 -Dfile.encoding=UTF-8 ${JAVA_OPTS}"

RUN curl -SLO --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/"${ARCHIVE}" \
    && curl -SL https://www.oracle.com/webfolder/s/digest/"${VERSION}"u"${UPDATE}"checksum.html \
    | grep $(sha256sum "${ARCHIVE}" | cut -d ' ' -f1) \
    | grep -q "${ARCHIVE}" \
    && tar -xf "${ARCHIVE}" -C $(dirname $JAVA_HOME) \
    && rm "${ARCHIVE}" \
    && chown root:root -R "${JAVA_HOME}" \
    && alternatives --install /usr/bin/java java "${JAVA_HOME}/jre/bin/java" 1000

ENV PATH "${JAVA_HOME}/jre/bin":$PATH
