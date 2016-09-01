# PHP-FPM on CentOS 7

[![](https://images.microbadger.com/badges/image/macedigital/phpfpm.svg)](https://microbadger.com/images/macedigital/phpfpm "Get your own image badge on microbadger.com")
![](https://img.shields.io/docker/stars/macedigital/phpfpm.svg "Docker stars")
![](https://img.shields.io/docker/pulls/macedigital/phpfpm.svg "Image pulls")
[![](https://img.shields.io/docker/automated/macedigital/phpfpm.svg)](https://hub.docker.com/r/macedigital/phpfpm/ "Docker Hub page")

For running PHP projects with PHP-FPM on CentOS with packages from the [Webtatic PHP repository](https://webtatic.com/).

## Usage

Get the image from the Docker hub:

````
docker pull macedigital/phpfpm
````

### Available tags:

`macedigital/phpfpm:7.0`: Provides PHP 7.0.x

`macedigital/phpfpm:5.6`: Provides PHP 6.5.x

Omitting a tag pulls in the latest PHP version, which may or may not be what you want (as it depends greatly on the application you're going to run).

### Example

The image comes preconfigured to listen on port `9000` and serve files from `/var/www`

````bash
CONTAINER_NAME=myphpapp
HOST_SOURCES=/path/to/project/sources
HOST_PORT=9000
docker run --name $CONTAINER_NAME -d --restart=always -v $HOST_SOURCES:/var/www -p $HOST_PORT:9000 macedigital/phpfpm
````

Above snippet will run the container with the name `myphpapp`, link the `/path/to/project/sources` and expose the FastCGI handler on host systems's port `9000`.
On failure (e.g. a segfaulting PHP-FPM master process) the whole container will be restarted.

Now, all you need is a web-server with fastcgi capabilities, e.g. [nginx](http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html), and proxy requests.

## Available modules

The image uses PHP packages from the https://webtatic.com repository.

The following modules are provided:
- bcmath
- gd
- imap
- intl
- ldap
- mbstring
- mcrypt
- mysqlnd
- opcache
- pdo
- pgsql
- process
- recode
- soap
- xml

## Extensions

All images come with these pecl-extensions by default:

- pecl-apcu
- pecl-imagick

Images tagged with `5.6` have the following additional pecl-extensions installed:

- pecl-igbinary
- pecl-memcache
- pecl-memcached
- pecl-mongodb
- pecl-redis

Please note, that these are not (yet?) available for PHP 7.x and that there are in fact very few pecl-extensions available for this version.

## Development & Customization

This base image is intended for *running* PHP applications.

Install these packages if you want to use the image for development and debugging:

`# yum install php70w-devel php70w-phpdbg php70w-pecl-xdebug`

Likewise you can extend the image and install additional libraries, e.g. if you plan on installing custom pecl-extensions, you'll have to install additional dependencies.

Here is an example for installing the `pecl-solr` extension from within a running container (as root):

````sh
yum install -y php56w-devel make gcc libxml2-devel curl-devel
pecl install -f pecl/solr && echo "extension=solr.so" > /etc/php.d/solr.ini
# optional cleanup:
# yum remove -y php56w-devel make gcc libxml2-devel curl-devel && yum clean all
````

## Issues & Feedback

If you have any issue, you can post in the github issue tracker. Please use the `phpfpm` label when doing so. 
