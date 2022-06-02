FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y php-fpm \
    php-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www /run/php

WORKDIR /var/www/

COPY ./tools/* .

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

EXPOSE 9000

ENTRYPOINT [ "./entry.sh" ]

CMD ["php-fpm7.3", "-F", "-R"]
