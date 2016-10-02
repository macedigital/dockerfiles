# nginx + http/2 + brotli_static

[![](https://images.microbadger.com/badges/image/macedigital/nginx.svg)](https://microbadger.com/images/macedigital/nginx "Get your own image badge on microbadger.com")
[![](https://img.shields.io/docker/automated/macedigital/nginx.svg)](https://hub.docker.com/r/macedigital/nginx/ "Docker Hub page")

Latest nginx mainline with HTTP/2 and static brotli compression support.

Build instructions are based on [offical nginx Dockerfile](https://github.com/nginxinc/docker-nginx/blob/e117bd83e9befe5582bc1da8f72248398fffa16c/mainline/alpine/Dockerfile) and [Alpine package script](http://git.alpinelinux.org/cgit/aports/tree/main/nginx/APKBUILD). 

## Built-ins

- HTTP/2 support via statically compiled [LibreSSL](http://libressl.org/) instead of OpenSSL.
- Has [ngx_brotli](https://github.com/google/ngx_brotli) included (static only at the moment).

## Dynamic modules

List of [loadable modules](http://nginx.org/en/docs/ngx_core_module.html#load_module):

- ngx_http_geoip_module.so
- ngx_http_headers_more_filter_module.so
- ngx_http_image_filter_module.so
- ngx_http_xslt_filter_module.so
- ngx_mail_module.so
- ngx_rtmp_module.so
- ngx_stream_geoip_module.so
- ngx_stream_module.so

All modules are located in `/usr/lib/nginx/modules`.

## Usage

Run a hello world container:

````bash
docker run -d -p 80:80 --name=nginx --memory=64MB macedigital/nginx
````

## TODO / IDEAS
- Check compiler settings (security/code optimization)
- ~~Rethink stdout/stderr redirection for logs~~ Customizable via `docker run` options
- ~~Setup cache folders as tmpfs / shm~~ Can be achieved via `docker run` options
- ~~Consistent UID/GID combo~~ Workers run with UID 99 which corresponds to user `nobody` on most distros.
