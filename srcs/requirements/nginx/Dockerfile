FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

COPY ./tools/entry.sh .

EXPOSE 443

ENTRYPOINT [ "./entry.sh" ]

CMD ["nginx", "-g", "daemon off;"]
