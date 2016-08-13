## Oracle JRE 8.x server

Base image for building headless JVM applications using the server runtime from Oracle.

To use this image or Dockerfile, you *must* accept the [Oracle Binary Code License Agreement](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) for Java SE!

## Usage

Pull the image: `docker pull macedigital/jre-server`

Run a container: `docker run -ti macedigital/jre-server bash`

## Configuration

The base image configures to use UTF-8 file encoding by setting these defaults:

`JAVA_OPTS="-Djavax.servlet.request.encoding=UTF-8 -Dfile.encoding=UTF-8 ${JAVA_OPTS}"`

Also all binaries in `$JAVA_HOME/jre/bin` are exposed to `$PATH`.

## Examples

This image is just a starting point, but can be easily extended.

Here is how you could setup a **minimal** [Jenkins](https://jenkins.io/) container:

````Dockerfile
FROM macedigital/jre-server

RUN curl -SL http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war -o /opt/jenkins.war

EXPOSE 8080

CMD java ${JAVA_OPTS} -jar /opt/jenkins.war
````

Please do not use this example in any production environment ;)
