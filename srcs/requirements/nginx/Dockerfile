FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y \
    nginx \
    openssl

WORKDIR /tmp

COPY ./tools/setup.sh .

RUN sh setup.sh

EXPOSE 443

ENTRYPOINT [ "tail", "-f" ]
