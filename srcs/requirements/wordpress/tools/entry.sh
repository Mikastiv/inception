#!/bin/bash

set -euo pipefail

# SELECT ID,user_login,meta_key,meta_value FROM wp_users AS wpu INNER JOIN wp_usermeta AS wpm ON wpm.user_id=wpu.ID WHERE wpm.meta_key='wp_capabilities' GROUP BY wpm.meta_value;

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
            --admin_email="${MYSQL_EMAIL}" \
            --skip-email \
            --url="${DOMAIN_NAME}" \
            --path="/var/www/html"
        wp user create --allow-root \
            $WP_USER \
            $WP_EMAIL \
            --role=author \
            --user_pass=$WP_PWD \
            --path="/var/www/html"
    fi

    echo "Wordpress listening on port 9000"
fi

exec "$@"
