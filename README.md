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

### Dockerfile building

```docker
# latest tag
FROM npulidom/alpine-nginx-php

# working directory
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
