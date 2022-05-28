FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    mariadb-client

ARG MYSQL_DATABASE
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD

ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
ENV MYSQL_USER=$MYSQL_USER
ENV MYSQL_PASSWORD=$MYSQL_PASSWORD

WORKDIR /tmp

COPY ./setup.sh .
COPY ./setup_db.sql .

RUN sh setup.sh && rm setup.sh

RUN service mysql start && mysql -u root < setup_db.sql && rm setup_db.sql

EXPOSE 3306

ENTRYPOINT [ "mysqld" ]
