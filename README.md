alpine-nginx-php
================

Nginx running in Alpine with PHP 7.2.x (fpm), developed for PHP apps.  
Uncompressed size: 114 Mb.

## Usage

Run Container [local exposed port **8080**]  
`docker run -p 8080:80 -d npulidom/alpine-nginx-php`

Entry point options  
`--nginx-env` : export env vars to nginx, var must have at least one underscore, ie: *APP_ENV*, *APP_TZ*.

Build Arguments (see build file)	
`timezone="America/Santiago"`

Nginx runs as `www-data` user.

### Dockerfile building

```docker
# latest tag for stable
FROM npulidom/alpine-nginx-php:edge

# working dir
WORKDIR /var/www

# extra ops ...

# start supervisor
CMD ["--nginx-env"]
```

## Packages & PHP Extensions

- bash
- supervisord
- nano
- curl
- gettext
- php7
- php7-curl
- php7-dom
- php7-fpm
- php7-gettext
- php7-json
- php7-mbstring
- php7-mysqlnd
- php7-pdo
- php7-pdo_mysql
- php7-phar
- php7-opcache
- php7-openssl
- php7-session
- php7-xml
- php7-zlib
- composer
