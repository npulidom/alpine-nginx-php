alpine-nginx-php
================

Nginx running in Alpine with PHP 7.3.x (fpm), developed for PHP apps.
Uncompressed size: ~104 MB.

## Usage

Run Container [local exposed port **8080**].

```sh
# nginx runs as www-data user

docker run -p 8080:80 -d npulidom/alpine-nginx-php
```

Entry point options
```yaml
--nginx-env : export env vars to nginx, var must have at least one underscore, ie: *APP_ENV*, *APP_TZ*.
```

Build Arguments (see build file)
```yaml
timezone="America/Santiago"
```

### Build Image

```docker
FROM your/image

# install any other package...
# apk add --no-cache php7-mysqli && rm -rf /var/cache/apk/*

# working directory
WORKDIR /var/www

# composer install dependencies
COPY composer.json .
RUN composer install --no-dev && composer dump-autoload --optimize --no-dev

# project code
COPY . .

# start supervisor
CMD ["--nginx-env"]
```

## Packages & PHP Extensions

- bash
- supervisord
- curl
- gettext
- composer
- php
- php-curl
- php-dom
- php-fileinfo
- php-fpm
- php-gettext
- php-json
- php-mbstring
- php-mongodb
- php-pdo
- php-phar
- php-opcache
- php-openssl
- php-session
- php-simplexml
- php-tokenizer
- php-xml
- php-zlib
