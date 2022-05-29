#!/bin/sh

# Install wp-cli
chmod +x wp-cli.phar
mv wp-cli.phar wp-cli

# Install wordpress
tar -xzf wordpress-6.0.tar.gz
rm wordpress-6.0.tar.gz
mv wordpress html

# Config php
mkdir -p /run/php
sed -i '/listen = \/run\/php\/php7.3-fpm.sock/c listen = 9000' /etc/php/7.3/fpm/pool.d/www.conf

rm setup.sh
