#!/bin/sh

# Set the port
sed -Ei '/^(#)?port/c port                    = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf

# Remove bind to local host
sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf
