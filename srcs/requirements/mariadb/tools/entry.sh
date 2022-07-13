#!/bin/bash

set -euo pipefail

if [ "$1" = 'mysqld' ]; then
    if [ ! -d "/run/mysqld" ]; then
        mkdir -p /run/mysqld
        chown -R mysql:mysql /run/mysqld
    fi

    # Set the port
    sed -Ei '/^(#)?port/c port                    = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf
    # Allow remote connections
    sed -i '/^bind-address/c bind-address            = 0.0.0.0' /etc/mysql/mariadb.conf.d/50-server.cnf
    # Set the datadir
    sed -Ei "/^datadir/c datadir                 = $MYSQL_DATADIR" /etc/mysql/mariadb.conf.d/50-server.cnf

    if [ ! -f "$MYSQL_DATADIR/initdb.sql" ]; then
        chown -R mysql:mysql $MYSQL_DATADIR

        mysql_install_db --datadir=$MYSQL_DATADIR --user=mysql --skip-test-db > /dev/null

        # Create SQL script
        cat >"$MYSQL_DATADIR/initdb.sql" <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

        # Setup database
        mysqld &
        for i in {0..30}; do
            if mariadb -u root -proot --database=mysql <<<'SELECT 1;' &> /dev/null; then
                break
            fi
            sleep 1
        done
        if [ "$i" = 30 ]; then
            echo "Error while starting server"
        fi
        mariadb -u root -proot < "$MYSQL_DATADIR/initdb.sql" && killall mysqld
    fi

    echo "MariaDB listening on port 3306"
fi

exec "$@"
