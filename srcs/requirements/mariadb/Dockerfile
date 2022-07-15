FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

COPY ./tools/entry.sh .
COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT [ "./entry.sh" ]

CMD ["mysqld"]
