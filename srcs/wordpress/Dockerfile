FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y php-fpm \
    php-mysql

RUN mkdir -p /var/www

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_SERVER

ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_USER=$MYSQL_USER
ENV MYSQL_PASSWORD=$MYSQL_PASSWORD
ENV MYSQL_SERVER=$MYSQL_SERVER

WORKDIR /var/www

COPY wordpress-6.0.tar.gz .
COPY wp-cli.phar .
COPY ./setup.sh .

RUN sh setup.sh && rm setup.sh

COPY ./wp-config.php html/.

EXPOSE 9000

CMD ./wp-cli core install --allow-root \
    --title="Wordpress" \
    --admin_name="${MYSQL_USER}" \
    --admin_password="${MYSQL_PASSWORD}" \
    --admin_email="mleblanc@student.42quebec.com" \
    --path="/var/www/html/" \
    --url="localhost" \
    && rm ./wp-cli

ENTRYPOINT ["php-fpm7.3", "-F", "-R"]
