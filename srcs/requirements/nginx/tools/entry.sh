#!/bin/bash

if [ "$1" = "nginx" ]; then
    mkdir /etc/nginx/ssl

    cd /etc/nginx/ssl

    openssl req -x509 \
        -sha256 -days 3650 \
        -nodes \
        -newkey rsa:2048 \
        -subj "/CN=$DOMAIN_NAME/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec" \
        -keyout rootCA.key \
        -out rootCA.crt

    openssl genrsa -out $CERT_KEY 2048

    cat > csr.conf <<EOF
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = CA
ST = Quebec
L = Quebec City
O = 42 Network
OU = 42 Quebec
CN = $DOMAIN_NAME

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $DOMAIN_NAME
EOF

    openssl req -new -key $CERT_KEY -out server.csr -config csr.conf

    cat > cert.conf <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN_NAME
EOF
    openssl x509 -req \
        -in server.csr \
        -CA rootCA.crt -CAkey rootCA.key \
        -CAcreateserial -out $CERT_CRT \
        -days 365 \
        -sha256 -extfile cert.conf

    echo "NGINX started"
fi

exec "$@"
