#!/bin/bash

if [ "$1" = "php-fpm7.3" ]; then

    for i in {0..30}; do
        if mariadb -h$MYSQL_SERVER -u$MYSQL_USER -p$MYSQL_PASSWORD --database=$MYSQL_DATABASE <<<'SELECT 1;' &>/dev/null; then
            break
        fi
        sleep 2
    done
    if [ "$i" = 30 ]; then
        echo "Can't connect to database"
    fi

    if [ ! -f "/var/www/html/wp-config.php" ]; then
        # Config php
        sed -i '/listen = \/run\/php\/php7.3-fpm.sock/c listen = 9000' /etc/php/7.3/fpm/pool.d/www.conf

        # Install wordpress
        tar -xzf wordpress-6.0.tar.gz
        rm wordpress-6.0.tar.gz
        mv wordpress//* html/
        rm -rf wordpress

        wp config create --allow-root \
            --dbname=$MYSQL_DATABASE \
            --dbuser=$MYSQL_USER \
            --dbpass=$MYSQL_PASSWORD \
            --dbhost=$MYSQL_SERVER \
            --dbcharset="utf8" \
            --dbcollate="utf8_general_ci" \
            --path="/var/www/html"
        wp core install --allow-root \
            --title="Wordpress" \
            --admin_name="${MYSQL_USER}" \
            --admin_password="${MYSQL_PASSWORD}" \
            --admin_email="mleblanc@student.42quebec.com" \
            --skip-email \
            --url="${DOMAIN_NAME}" \
            --path="/var/www/html"
    fi
fi

echo "Wordpress listening on port 9000"
exec "$@"
