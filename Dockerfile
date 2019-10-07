# OS alpine 3.9
FROM nginx:1.15-alpine
LABEL maintainer="nicolas.pulido@crazycake.tech"

# alpine & nginx version
RUN cat /etc/os-release | grep PRETTY_NAME && nginx -v

# build arguments
ARG timezone="America/Santiago"

# codecasts/php-alpine repository
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# add repository
RUN echo "https://dl.bintray.com/php-alpine/v3.9/php-7.3" >> /etc/apk/repositories

# packages
RUN apk update && apk add --no-cache \
	bash \
	supervisor \
	tzdata \
	gettext \
	curl \
	# php
	php \
	php-curl \
	php-dom \
	php-fpm \
	php-gettext \
	php-json \
	php-mbstring \
	php-mongodb \
	php-openssl \
	php-pdo \
	php-phar \
	php-opcache \
	php-session \
	php-xml \
	php-zlib \
	&& rm -rf /var/cache/apk/*

# directory links
RUN ln -s /etc/php7 /etc/php && \
	ln -s /usr/bin/php7 /usr/bin/php && \
	ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
	ln -s /usr/lib/php7 /usr/lib/php

# timezone
ENV TZ=$timezone \
	COMPOSER_ALLOW_SUPERUSER=1

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && date

# php composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# set www-data group (82 is the standard uid/gid for www-data in Alpine)
RUN set -x ; \
	addgroup -g 82 -S www-data ; \
	adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# prepare folders
RUN rm /etc/nginx/conf.d/default.conf && \
	mkdir -p /var/www/public /var/log/supervisord

# copy files
COPY .bashrc /root/.bashrc
COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-sites.conf /etc/nginx/sites-enabled/default
COPY php-fpm.conf /etc/php7/php-fpm.d/www.conf
COPY index.php /var/www/public
COPY start /root/start

# expose
EXPOSE 80

# entrypoint
ENTRYPOINT ["/root/start"]
