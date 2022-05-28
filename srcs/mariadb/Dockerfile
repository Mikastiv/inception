FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    mariadb-client

ENV MYSQL_DATABASE=wordpress
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_USER=mleblanc
ENV MYSQL_PASSWORD=mypassword

WORKDIR /tmp

COPY ./setup.sh .
COPY ./setup_db.sql .

RUN sh setup.sh && rm setup.sh

RUN service mysql start && mysql -u root < setup_db.sql && rm setup_db.sql

EXPOSE 3306

ENTRYPOINT [ "mysqld" ]
