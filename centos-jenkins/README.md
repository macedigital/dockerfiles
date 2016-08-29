# Jenkins on CentOS

Base image for running Jenkins inside Docker.

## Build-time

The following defaults are applied:

````Dockerfile
# other options ...
ARG JENKINS_VERSION=2.7.2
ARG JENKINS_HOME=/var/lib/jenkins
ARG JENKINS_USER=jenkins
ARG JENKINS_GROUP=jenkins
ARG JENKINS_UID=1000
ARG JENKINS_GID=1000
ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war
# even more options
````

As an example, this is how you would rebuild with a specific Jenkins version:

`docker build --build-arg JENKINS_VERSION=2.20.0 -tag jenkins:latest .`

## Run-time

Additional Java options can be passed in the `JAVA_OPTS` environment variable. 

Jenkins runtime can be modified be setting options in the `JENKINS_OPTS` environment variable.

`docker run -e JAVA_OPTS="-Xmx128m" -e JENKINS_OPTS="--httpPort=1234 --prefix=/my-jenkins" macedigital/jenkins`

Above command is an example for how you would start a container with custom options.
