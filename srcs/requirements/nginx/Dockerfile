FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    nginx \
    openssl && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

WORKDIR /tmp

COPY ./tools/* .

ARG DOMAIN_NAME
ARG CERT_CRT
ARG CERT_KEY

ENV DOMAIN_NAME=$DOMAIN_NAME
ENV CERT_CRT=$CERT_CRT
ENV CERT_KEY=$CERT_KEY

RUN ./generate_cert.sh

EXPOSE 443

ENTRYPOINT [ "./entry.sh" ]

CMD ["nginx", "-g", "daemon off;"]
