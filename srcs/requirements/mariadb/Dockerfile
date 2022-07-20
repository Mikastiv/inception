FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    mariadb-server \
    mariadb-client && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

WORKDIR /tmp

COPY ./tools/entry.sh .
COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT [ "./entry.sh" ]

CMD ["mysqld"]
