# PHP-FPM on CentOS 7

[![](https://images.microbadger.com/badges/image/macedigital/phpfpm.svg)](https://microbadger.com/images/macedigital/phpfpm "Get your own image badge on microbadger.com")
![](https://img.shields.io/docker/stars/macedigital/phpfpm.svg "Docker stars")
![](https://img.shields.io/docker/pulls/macedigital/phpfpm.svg "Image pulls")
[![](https://img.shields.io/docker/automated/macedigital/phpfpm.svg)](https://hub.docker.com/r/macedigital/phpfpm/ "Docker Hub page")

For running PHP projects with PHP-FPM on CentOS.

## Usage

Get the image from the Docker hub:

````
docker pull macedigital/phpfpm
````

### Available tags:

`macedigital/phpfpm:latest`: Latest usable PHP version + possibly different configuration options than the tagged images use.

`macedigital/phpfpm:7.1`: Provides latest stable PHP 7.1.x version.

`macedigital/phpfpm:7.0`: Provides latest stable PHP 7.0.x version.

`macedigital/phpfpm:5.6`: Provides latest stable PHP 6.5.x version.

All images come preconfigured to listen on port `9000`, serve files from `/var/www`, and set the default timezone to `UTC`.

### Example

````bash
CONTAINER_NAME=myphpapp
HOST_SOURCES=/path/to/project/sources
HOST_PORT=9000
docker run --name $CONTAINER_NAME -d --restart=always -v $HOST_SOURCES:/var/www -p $HOST_PORT:9000 macedigital/phpfpm
````

Above snippet will run the container with the name `myphpapp`, link the `/path/to/project/sources` folder and expose the FastCGI handler on host systems's port `9000`.
On failure (e.g. a segfaulting PHP-FPM master process) the whole container will be restarted.

Now, all you need is a web-server with fastcgi capabilities, e.g. [nginx](http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html), and proxy requests:

````nginx
server {
    listen 80;

    # other config options

    location ~ \.php$ {
        # it's the path inside the container
        root /var/www;
        # change IP address :)
        fastcgi_pass 172.17.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
````

## Available modules

The image uses PHP packages from the [Webtatic PHP repository](https://webtatic.com/).

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

