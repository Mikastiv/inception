#!/bin/sh

# Set the port
sed -Ei '/^(#)?port/c port                    = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -Ei "/^datadir/c datadir                 = $MYSQL_DATADIR" /etc/mysql/mariadb.conf.d/50-server.cnf

# Remove bind to local host
sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Update SQL script
sed -i "s/MYSQL_DATABASE/$MYSQL_DATABASE/g" ./setup_db.sql
sed -i "s/MYSQL_USER/$MYSQL_USER/g" ./setup_db.sql
sed -i "s/MYSQL_PASSWORD/$MYSQL_PASSWORD/g" ./setup_db.sql
sed -i "s/MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" ./setup_db.sql

# Setup database
service mysql start && mysql -u root < setup_db.sql
rm setup_db.sql
