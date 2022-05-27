FROM debian:buster


RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    mariadb-client

WORKDIR /tmp

COPY ./setup.sh .
RUN sh setup.sh && rm setup.sh

COPY ./setupdb.sql .

RUN service mysql start && mysql -u root < setupdb.sql

EXPOSE 3306

ENTRYPOINT [ "mysqld" ]
