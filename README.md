# alpine-nginx-php

Nginx running in Alpine with PHP 7.4.x (fpm), developed for PHP apps.

## Usage

Run Container [local exposed port **8080**].

```sh
# run container, nginx runs as www-data user
docker run -p 8080:80 -d your/image
```

Entry point options

```yaml
--nginx-env: export env vars to nginx, var must have at least one underscore, ie. *APP_ENV*, *APP_TZ*.
```

Build Arguments (see build file)

```yaml
timezone="America/Santiago"
```

## Build

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
- php-pdo
- php-phar
- php-psr
- php-opcache
- php-openssl
- php-session
- php-simplexml
- php-tokenizer
- php-xml
- php-zlib
