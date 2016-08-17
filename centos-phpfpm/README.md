# PHP-FPM 7.x on CentOS 7

[![](https://images.microbadger.com/badges/image/macedigital/phpfpm.svg)](https://microbadger.com/images/macedigital/phpfpm "Get your own image badge on microbadger.com")
![](https://img.shields.io/docker/stars/macedigital/phpfpm.svg "Docker stars")
![](https://img.shields.io/docker/pulls/macedigital/phpfpm.svg "Image pulls")
[![](https://img.shields.io/docker/automated/macedigital/phpfpm.svg)](https://hub.docker.com/r/macedigital/phpfpm/ "Docker Hub page")

For running PHP 7.x projects with PHP-FPM on CentOS.

## Installation

Get the image from the Docker hub:

````
docker pull macedigital/phpfpm
````

## Usage

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
- pecl-apcu
- pecl-imagick
- pgsql
- process
- recode
- soap
- xml

Please note that this base image is intended for *running* PHP applications.

`# yum install php70w-devel php70w-phpdbg php70w-pecl-xdebug`

Install these packages if you want to use the image for development and debugging.


