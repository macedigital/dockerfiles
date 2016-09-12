FROM alpine:edge

RUN apk -U --no-cache add openjdk8

ENV PATH "/usr/lib/jvm/java-1.8-openjdk/bin:${PATH}"
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV JAVA_OPTS="-Djavax.servlet.request.encoding=UTF-8 -Dfile.encoding=UTF-8 ${JAVA_OPTS}"

