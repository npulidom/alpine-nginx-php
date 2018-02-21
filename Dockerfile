# OS
FROM nginx:alpine
LABEL maintainer="nicolas.pulido@crazycake.cl"

# packages
RUN apk update && apk add -U --no-cache \
	bash \
	supervisor \
	nano \
	curl \
	gettext \
	tzdata \
	php7 \
	php7-curl \
	php7-dom \
	php7-fpm \
	php7-gettext \
	php7-json \
	php7-mbstring \
	php7-mcrypt \
	php7-mysqlnd \
	php7-pdo \
	php7-pdo_mysql \
	php7-phar \
	php7-opcache \
	php7-openssl \
	php7-session \
	php7-xml \
	php7-zlib \
	&& rm -rf /var/cache/apk/*

# directory links
RUN ln -s /etc/php7 /etc/php && \
	ln -s /usr/bin/php7 /usr/bin/php && \
	ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
	ln -s /usr/lib/php7 /usr/lib/php

# timezone
ENV TZ=America/Santiago
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone && date

# php composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# set www-data group, prepare folders
RUN set -x && \
	addgroup -g 82 -S www-data && \
	adduser -u 82 -D -S -G www-data www-data && \
	rm /etc/nginx/conf.d/default.conf && \
	mkdir -p /var/www/public /var/log/supervisord

# copy files
COPY .bashrc /root/.bashrc
COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-sites.conf /etc/nginx/sites-enabled/default
COPY php-fpm.conf /etc/php7/php-fpm.d/www.conf
COPY start /root/start

# expose
EXPOSE 80

# entrypoint
ENTRYPOINT ["/root/start"]
