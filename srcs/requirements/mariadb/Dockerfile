FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

COPY ./tools/entry.sh .

EXPOSE 3306

ENTRYPOINT [ "./entry.sh" ]

CMD ["mysqld"]
